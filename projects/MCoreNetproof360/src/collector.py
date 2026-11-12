#!/usr/bin/env python3
"""
MCoreNetproof360 Python Measurement Engine
MCORE AIS/BOX-1.0 Sovereign Autonomous Intelligence Infrastructure
"""

import sys
import os
import time
import socket
import json
import hashlib
import subprocess
from datetime import datetime, timezone
from pathlib import Path
from urllib.request import urlopen, Request
from urllib.error import URLError, HTTPError

ROOT = Path(__file__).resolve().parent.parent
CONFIG_PATH = ROOT / "config" / "services.json"
EVIDENCE_DIR = ROOT / "evidence"

def probe_tcp(host, port, timeout=1.0):
    start = time.perf_counter()
    try:
        s = socket.create_connection((host, port), timeout=timeout)
        s.close()
        rtt_ms = (time.perf_counter() - start) * 1000.0
        return True, round(rtt_ms, 2)
    except Exception:
        rtt_ms = (time.perf_counter() - start) * 1000.0
        return False, round(rtt_ms, 2)

def probe_http(url, timeout=1.5):
    try:
        req = Request(url, headers={"User-Agent": "mcore-netproof/1.1.0"})
        with urlopen(req, timeout=timeout) as r:
            return True, str(r.status)
    except HTTPError as e:
        return False, str(e.code)
    except Exception:
        return False, "ERR"

def record_measurement_to_db(svc, ok, tcp_ok, http_status, rtt_ms, sha256_hash, raw_json):
    db_url = os.environ.get("DATABASE_URL", "postgres://mcoreai:mcoreai@localhost:5432/mcoreai")
    sql = """
    INSERT INTO measurements (service_id, zone, port, critical, ok, tcp_ok, http_status, rtt_ms, evidence_sha256, raw_evidence)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
    """
    raw_str = json.dumps(raw_json).replace("'", "''")
    cmd_sql = f"""
    INSERT INTO measurements (service_id, zone, port, critical, ok, tcp_ok, http_status, rtt_ms, evidence_sha256, raw_evidence)
    VALUES ('{svc['id']}', '{svc['zone']}', {svc['port']}, {str(svc['critical']).lower()}, {str(ok).lower()}, {str(tcp_ok).lower()}, '{http_status}', {int(rtt_ms)}, '{sha256_hash}', '{raw_str}'::jsonb);
    """
    try:
        subprocess.run(["psql", db_url, "-q", "-c", cmd_sql], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except Exception as e:
        pass

def run_measurement():
    if not CONFIG_PATH.exists():
        print(f"Error: Missing config file at {CONFIG_PATH}", file=sys.stderr)
        sys.exit(1)

    with open(CONFIG_PATH, "r", encoding="utf-8") as f:
        cfg = json.load(f)

    services = cfg.get("services", [])
    EVIDENCE_DIR.mkdir(parents=True, exist_ok=True)

    results = []
    print("==================================================================")
    print(" [NetProof360] Executing Sovereign Measurement Plane Probe...")
    print(" Authority: MCORE-FDR-AIS-001 | Target: Localhost & Service Zones")
    print("==================================================================")

    for svc in services:
        tcp_ok, rtt_ms = probe_tcp("127.0.0.1", svc["port"])
        http_ok = False
        http_status = "no-tcp"

        if tcp_ok:
            url = f"http://127.0.0.1:{svc['port']}{svc.get('path', '/health')}"
            http_ok, http_status = probe_http(url)

        overall_ok = tcp_ok and (http_ok or http_status in ["200", "404", "401"])
        
        raw_evidence = {
            "service_id": svc["id"],
            "zone": svc["zone"],
            "port": svc["port"],
            "critical": svc["critical"],
            "tcp_ok": tcp_ok,
            "http_status": http_status,
            "rtt_ms": rtt_ms,
            "timestamp": datetime.now(timezone.utc).isoformat()
        }

        hasher = hashlib.sha256()
        hasher.update(json.dumps(raw_evidence, sort_keys=True).encode("utf-8"))
        evidence_sha256 = hasher.hexdigest()

        raw_evidence["evidence_sha256"] = evidence_sha256
        results.append(raw_evidence)

        record_measurement_to_db(svc, overall_ok, tcp_ok, http_status, rtt_ms, evidence_sha256, raw_evidence)

        status_icon = "✅" if overall_ok else ("⚠️" if not svc["critical"] else "❌")
        crit_tag = "[CRIT]" if svc["critical"] else "      "
        print(f"  {status_icon} {crit_tag} {svc['id']:<18} Port: {svc['port']:<5} Zone: {svc['zone']} RTT: {rtt_ms:>6.2f}ms  SHA: {evidence_sha256[:12]}...")

    snapshot_file = EVIDENCE_DIR / "measurements_snapshot.json"
    with open(snapshot_file, "w", encoding="utf-8") as f:
        json.dump(results, f, indent=2)

    print("==================================================================")
    print(f" [NetProof360] Completed {len(results)} probes. Evidence stored in PostgreSQL & {snapshot_file}")
    print("==================================================================")
    return results

if __name__ == "__main__":
    run_measurement()
