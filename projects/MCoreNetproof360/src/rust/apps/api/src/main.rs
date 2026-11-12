use axum::{extract::State, routing::get, Json, Router};
use serde::Serialize;
use sqlx::{postgres::PgPoolOptions, FromRow, PgPool};
use std::net::SocketAddr;
use tower_http::{cors::CorsLayer, services::ServeDir};

#[derive(Clone)]
struct AppState {
    pool: PgPool,
}

#[derive(Serialize, FromRow)]
struct Measurement {
    service_id: String,
    zone: String,
    port: i32,
    ok: bool,
    rtt_ms: i64,
    evidence_sha256: String,
}

#[derive(Serialize)]
struct StateResponse {
    verdict: String,
    healthy: usize,
    total: usize,
    services: Vec<Measurement>,
}

async fn get_state(State(state): State<AppState>) -> Json<StateResponse> {
    let services = sqlx::query_as::<_, Measurement>(
        "SELECT DISTINCT ON (service_id) service_id, zone, port, ok, rtt_ms, evidence_sha256 \
         FROM measurements ORDER BY service_id, executed_at DESC",
    )
    .fetch_all(&state.pool)
    .await
    .unwrap_or_default();

    let total = services.len();
    let healthy = services.iter().filter(|s| s.ok).count();

    Json(StateResponse {
        verdict: if healthy == total && total > 0 {
            "ALL-HEALTHY".to_string()
        } else {
            "CRITICAL".to_string()
        },
        healthy,
        total,
        services,
    })
}

#[tokio::main]
async fn main() {
    dotenvy::dotenv().ok();
    let db_url = std::env::var("DATABASE_URL")
        .unwrap_or_else(|_| "postgres://mcoreai:mcoreai@localhost:5432/mcoreai".to_string());
    
    let pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(&db_url)
        .await
        .expect("Failed to connect to PostgreSQL");

    let web_dir = std::env::var("WEB_DIR").unwrap_or_else(|_| "../../web".to_string());

    let app = Router::new()
        .route("/monitor/state.json", get(get_state))
        .nest_service("/monitor/3d", ServeDir::new(web_dir))
        .layer(CorsLayer::permissive())
        .with_state(AppState { pool });

    let addr = SocketAddr::from(([0, 0, 0, 0], 8787));
    println!("🚀 MCoreNetproof360 Axum API running on http://{}", addr);
    axum::serve(tokio::net::TcpListener::bind(addr).await.unwrap(), app)
        .await
        .unwrap();
}
