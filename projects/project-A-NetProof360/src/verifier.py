#!/usr/bin/env python3
"""
NetProof360 Zero-Trust Route & Telemetry Verifier
MCORE AIS/BOX-1.0 Sovereign Autonomous Intelligence Infrastructure
"""

import sys
import os
import json
import hashlib
from datetime import datetime, timezone

class NetProofVerifier:
    def __init__(self, evidence_dir=None):
        base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        self.evidence_dir = evidence_dir or os.path.join(base_dir, "evidence")
        self.snapshot_file = os.path.join(self.evidence_dir, "telemetry_snapshot.json")
        self.attestation_file = os.path.join(self.evidence_dir, "network_attestation.json")

    def verify(self):
        if not os.path.exists(self.snapshot_file):
            from collector import NetProofCollector
            collector = NetProofCollector()
            collector.collect()

        with open(self.snapshot_file, "r", encoding="utf-8") as f:
            snapshot = json.load(f)

        probes = snapshot.get("probes", [])
        total = len(probes)
        reachable = sum(1 for p in probes if p.get("reachable"))
        critical_unreachable = [p for p in probes if p.get("criticality") == "CRITICAL" and not p.get("reachable")]

        # Verification Invariant: Zero Critical Services can be breached
        passed = len(critical_unreachable) == 0
        overall_status = "ATTESTED_SOVEREIGN" if passed else "QUENCH_REQUIRED"

        # Calculate attestation token
        attestation_payload = {
            "attestation_id": f"attest-netproof-{datetime.now(timezone.utc).strftime('%Y%m%d-%H%M%S')}",
            "generated_at": datetime.now(timezone.utc).isoformat(),
            "node_id": snapshot.get("node_id"),
            "route_state_hash": snapshot.get("route_state_hash"),
            "total_probes": total,
            "reachable_probes": reachable,
            "critical_failures": len(critical_unreachable),
            "status": overall_status,
            "authority": "MCORE-FDR-AIS-001"
        }

        token_raw = json.dumps(attestation_payload, sort_keys=True).encode("utf-8")
        attestation_payload["proof_signature"] = hashlib.sha256(token_raw).hexdigest()

        with open(self.attestation_file, "w", encoding="utf-8") as f:
            json.dump(attestation_payload, f, indent=2)

        print(f"[NetProof360] Verification complete. Status: {overall_status}")
        print(f"[NetProof360] Attestation Proof Signature: {attestation_payload['proof_signature']}")
        print(f"[NetProof360] Attestation saved to: {self.attestation_file}")
        return attestation_payload

if __name__ == "__main__":
    verifier = NetProofVerifier()
    verifier.verify()
