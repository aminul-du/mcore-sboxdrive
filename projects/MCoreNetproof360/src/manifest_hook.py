#!/usr/bin/env python3
"""
Registers evidence into the PostgreSQL manifest.
MCORE AIS/BOX-1.0 Sovereign Autonomous Intelligence Infrastructure
"""
import os
import sys
import subprocess

def register_evidence(sha256_hash: str):
    db_url = os.environ.get("DATABASE_URL", "postgres://mcoreai:mcoreai@localhost:5432/mcoreai")
    print(f"[Manifest Hook] Registering evidence hash {sha256_hash} into PostgreSQL manifest...")
    sql = f"""
    INSERT INTO measurements (service_id, zone, port, critical, ok, tcp_ok, http_status, rtt_ms, evidence_sha256, raw_evidence)
    VALUES ('manifest-hook', 'Z2', 0, false, true, true, '200', 0, '{sha256_hash}', '{{\"hook\": true}}'::jsonb);
    """
    try:
        subprocess.run(["psql", db_url, "-q", "-c", sql], check=True)
        print(f"[Manifest Hook] Successfully registered hash: {sha256_hash}")
    except Exception as e:
        print(f"[Manifest Hook] Error recording hash to DB: {e}", file=sys.stderr)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        register_evidence(sys.argv[1])
    else:
        print("Usage: manifest_hook.py <sha256_hash>")
