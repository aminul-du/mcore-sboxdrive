# MCoreNetproof360 / SBoxDrive Sovereign Export

**Project:** MCoreNetproof360  
**Standard:** MCORE AIS/BOX-1.0 SAII 2050 Baseline  
**Authority:** Founder Aminul Islam Shamim (AIS) | ID: `MCORE-FDR-AIS-001`  
**Status:** Production-Ready / Zero-Gap Architecture  

## 1. Mission
Enterprise-grade network measurement, telemetry, evidence, troubleshooting, and AI-assisted fault-localization platform. Features:
- Rust-first measurement plane generating deterministic SHA-256 evidence.
- PostgreSQL 16 + pgvector datastore storing raw JSONB measurements and vector embeddings.
- Rust Axum REST API control plane.
- Live 3D Operational Topology dashboard rendered with Three.js.
- Zero-gap L1-L7 Python monitors and SBoxDrive manifest integrity enforcement.

## 2. System Architecture
```text
+-------------------+      SHA-256 Proof       +---------------------+
| Rust Measurement  | -----------------------> | PostgreSQL 16       |
| Plane (Tokio)     |                          | + pgvector Datastore|
+-------------------+                          +----------+----------+
                                                          |
                                                          v
+-------------------+      WebSocket / JSON    +----------+----------+
| 3D Operational    | <----------------------- | Rust Axum REST API  |
| Topology (ThreeJS)|                          | Control Plane (:8787|
+-------------------+                          +---------------------+
```

## 3. Quick Start

### Database Setup:
```bash
# PostgreSQL with pgvector is already pre-configured:
# postgres://mcoreai:mcoreai@localhost:5432/mcoreai
psql -U mcoreai -h localhost -d mcoreai -f src/rust/migrations/20231112000000_init.sql
```

### Run Python Measurement & L1-L7 Verifier:
```bash
python3 src/collector.py
python3 src/verifier.py
```

### Generate Cryptographic Manifest & ZIP:
```bash
bash scripts/generate-manifest.sh
```

### Run Rust Measurement Plane (when Cargo is installed):
```bash
cd src/rust
cargo run -p mcore-measurement
cargo run -p mcore-api
```

## 4. Security & Governance
- Zero Real Credentials: No secrets are hardcoded.
- Authority Anchor: `MCORE-FDR-AIS-001`.
- Doctrine: SAII Zero-Cost Bare-Metal Strategy.
