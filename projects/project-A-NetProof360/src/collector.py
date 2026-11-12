#!/usr/bin/env python3
"""
NetProof360 Telemetry Collector
MCORE AIS/BOX-1.0 Sovereign Autonomous Intelligence Infrastructure
"""

import sys
import os
import time
import socket
import json
import hashlib
from datetime import datetime, timezone

class NetProofCollector:
    def __init__(self, node_id="nativebox-ais001.mcoreai.dev"):
        self.node_id = node_id
        self.timestamp = datetime.now(timezone.utc).isoformat()
        self.evidence_dir = os.path.join(os.path.dirname(__file__), "..", "evidence")
        os.makedirs(self.evidence_dir, exist_ok=True)

    def probe_port(self, host, port, timeout=1.0):
        start = time.perf_counter()
        try:
            with socket.create_connection((host, port), timeout=timeout):
                latency_ms = (time.perf_counter() - start) * 1000.0
                return {"reachable": True, "latency_ms": round(latency_ms, 3), "error": None}
        except Exception as e:
            latency_ms = (time.perf_counter() - start) * 1000.0
            return {"reachable": False, "latency_ms": round(latency_ms, 3), "error": str(e)}

    def collect(self):
        targets = [
            {"id": "mcoresec-api", "host": "127.0.0.1", "port": 8000, "criticality": "HIGH"},
            {"id": "memory-trust-engine", "host": "127.0.0.1", "port": 8001, "criticality": "CRITICAL"},
            {"id": "terminal-ai", "host": "127.0.0.1", "port": 8002, "criticality": "MEDIUM"},
            {"id": "qdrant-vector", "host": "127.0.0.1", "port": 6333, "criticality": "HIGH"},
            {"id": "postgresql", "host": "127.0.0.1", "port": 5432, "criticality": "HIGH"},
            {"id": "colab-backend", "host": "127.0.0.1", "port": 8888, "criticality": "MEDIUM"},
            {"id": "cloudflared-metrics", "host": "127.0.0.1", "port": 2000, "criticality": "HIGH"}
        ]

        probe_results = []
        raw_signature_bytes = bytearray()

        for t in targets:
            res = self.probe_port(t["host"], t["port"])
            entry = {
                "probe_id": f"probe-{t['id']}",
                "target": f"{t['host']}:{t['port']}",
                "criticality": t["criticality"],
                "reachable": res["reachable"],
                "latency_ms": res["latency_ms"],
                "error": res["error"]
            }
            probe_results.append(entry)
            raw_signature_bytes.extend(f"{entry['probe_id']}:{entry['reachable']}:{entry['latency_ms']}".encode())

        route_state_hash = hashlib.sha256(raw_signature_bytes).hexdigest()

        snapshot = {
            "version": "1.0.0",
            "node_id": self.node_id,
            "timestamp": self.timestamp,
            "total_probes": len(probe_results),
            "route_state_hash": route_state_hash,
            "probes": probe_results
        }

        output_file = os.path.join(self.evidence_dir, "telemetry_snapshot.json")
        with open(output_file, "w", encoding="utf-8") as f:
            json.dump(snapshot, f, indent=2)

        print(f"[NetProof360] Telemetry collected successfully: {len(probe_results)} probes.")
        print(f"[NetProof360] Route State SHA-256: {route_state_hash}")
        print(f"[NetProof360] Snapshot written to: {output_file}")
        return snapshot

if __name__ == "__main__":
    collector = NetProofCollector()
    collector.collect()
