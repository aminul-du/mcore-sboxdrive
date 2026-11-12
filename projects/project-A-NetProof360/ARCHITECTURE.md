# NetProof360 System Architecture
### Formal Specification & Multi-Plane Integration

---

## 1. Architectural Philosophy
NetProof360 operates on the principle that network topology cannot be trusted based on static DNS or routing tables. In an autonomous agentic mesh, communication hops between agents, MCP gateways, and local bare-metal runtimes must provide continuous mathematical proof of:
1. Origin authenticity
2. Unaltered transit routes
3. Latency & jitter bounds
4. Cryptographic tunnel integrity

## 2. Four-Tier Verification Pipeline

1. **Layer 1: Ingress Probe Collector (`collector.py`)**
   Active synthetic ICMP/HTTP/QUIC probes, latency histograms, TLS fingerprint validation, and local socket state mapping.

2. **Layer 2: Proof & Attestation Generator (`verifier.py`)**
   SHA-256 state hashing of route hops, HMAC verification, Zero-Trust verification against policy thresholds.

3. **Layer 3: External AI Threat Ingestion (DeepSeek Ingest)**
   Heuristic anomaly matching, signature correlation, and comparative telemetry cross-referenced against AI research models.

4. **Layer 4: Evidence & SBoxDrive Manifest Hook**
   Generates verifiable evidence.json and registers artifacts in the unified SBoxDrive repository manifest.

## 3. Telemetry Schema
```json
{
  "probe_id": "probe-ais-netproof-001",
  "timestamp": "2026-11-13T05:25:00Z",
  "source": "nativebox-ais001.mcoreai.dev",
  "target": "colab.mcoreai.dev",
  "protocol": "QUIC/TLS1.3",
  "rtt_ms": 1.24,
  "route_hash": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  "status": "VERIFIED_SOVEREIGN"
}
```

## 4. Integration with MCore SAII Planes
- **Plane 1 (Data Plane):** Verifies edge packet flows without introducing proxy bottlenecks.
- **Plane 3 (Security Plane):** Validates certificate pinning and quenches untrusted ingress paths.
- **Plane 10 (Verification Plane):** Emits cryptographic evidence before claims are accepted.
- **Plane 11 (Trust Plane):** Computes confidence scores for routing nodes.
