use serde::{Deserialize, Serialize};
use sha2::{Digest, Sha256};
use sqlx::postgres::PgPoolOptions;
use std::fs;
use std::time::{Duration, Instant};
use tokio::net::TcpStream;
use tokio::time::timeout;

#[derive(Deserialize, Debug, Clone)]
struct Service {
    id: String,
    zone: String,
    port: u16,
    path: String,
    critical: bool,
}

#[derive(Deserialize)]
struct Config {
    services: Vec<Service>,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
struct Evidence {
    id: String,
    zone: String,
    port: u16,
    critical: bool,
    ok: bool,
    tcp_ok: bool,
    http_status: String,
    rtt_ms: u128,
    sha256: String,
    timestamp: String,
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    dotenvy::dotenv().ok();
    let db_url = std::env::var("DATABASE_URL")
        .unwrap_or_else(|_| "postgres://mcoreai:mcoreai@localhost:5432/mcoreai".to_string());
    
    let pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(&db_url)
        .await?;
    println!("✅ Connected to PostgreSQL ({})", db_url);

    let cfg_str = fs::read_to_string("config/services.json")
        .or_else(|_| fs::read_to_string("../../config/services.json"))
        .expect("Missing config/services.json");
    let cfg: Config = serde_json::from_str(&cfg_str)?;

    println!("▶ Executing NetProof360 Rust Measurement Plane (Tokio)...");

    for svc in cfg.services {
        let start = Instant::now();
        let addr = format!("127.0.0.1:{}", svc.port);
        let tcp_ok = match timeout(Duration::from_millis(1000), TcpStream::connect(&addr)).await {
            Ok(Ok(_)) => true,
            _ => false,
        };

        let mut http_status = "no-tcp".to_string();
        let mut ok = false;
        if tcp_ok {
            let url = format!("http://{}{}", addr, svc.path);
            if let Ok(resp) = reqwest::get(&url).await {
                http_status = resp.status().to_string();
                ok = resp.status().is_success();
            } else {
                http_status = "err".to_string();
            }
        }

        let rtt_ms = start.elapsed().as_millis();
        let raw_json = serde_json::json!({
            "service": svc.id,
            "zone": svc.zone,
            "port": svc.port,
            "critical": svc.critical,
            "ok": ok,
            "tcp_ok": tcp_ok,
            "http_status": http_status,
            "rtt": rtt_ms
        });

        let mut hasher = Sha256::new();
        hasher.update(serde_json::to_string(&raw_json)?.as_bytes());
        let sha256 = format!("{:x}", hasher.finalize());

        println!(
            "  {} [{:4}] {:20} :{}  RTT: {:3}ms  SHA: {}...",
            if ok { "✅" } else { "❌" },
            if svc.critical { "CRIT" } else { "" },
            svc.id,
            svc.port,
            rtt_ms,
            &sha256[0..8]
        );

        sqlx::query(
            "INSERT INTO measurements (service_id, zone, port, critical, ok, tcp_ok, http_status, rtt_ms, evidence_sha256, raw_evidence) \
             VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)"
        )
        .bind(&svc.id)
        .bind(&svc.zone)
        .bind(svc.port as i32)
        .bind(svc.critical)
        .bind(ok)
        .bind(tcp_ok)
        .bind(&http_status)
        .bind(rtt_ms as i64)
        .bind(&sha256)
        .bind(&raw_json)
        .execute(&pool)
        .await?;
    }

    println!("✅ All measurements recorded to PostgreSQL.");
    Ok(())
}
