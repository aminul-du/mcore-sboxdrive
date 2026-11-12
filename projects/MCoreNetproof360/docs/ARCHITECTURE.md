# MCoreNetproof360 Architecture

## 1. Architectural Planes
1. **Measurement Plane (Rust):** Executes real TCP/HTTP probes against all 8 local and edge services, computes RTT, and generates canonical SHA-256 evidence.
2. **Data Plane (PostgreSQL + pgvector):** Stores raw evidence (`raw_evidence JSONB`), cryptographic hashes (`evidence_sha256`), and vector embeddings for AI agent memory.
3. **Control Plane (Rust Axum):** Serves the REST API (`/monitor/state.json`) and the live 3D Dashboard.
4. **Verification Plane (Python):** Zero-Gap monitors (L1-L7) that continuously verify system state, probe compliance, and security boundaries.

## 2. End-to-End Data Flow
```text
[Rust / Python Probe] 
        ↓
[Canonical SHA-256 Evidence] 
        ↓
[PostgreSQL 16 + pgvector Table: measurements] 
        ↓
[Rust Axum API (:8787)] 
        ↓
[Three.js 3D Operational Dashboard]
```

## 3. Zero-Gap Principles
- No PASS verdict without executable evidence and non-zero SHA-256 state hashes.
- Immutable hashes for every measurement row in PostgreSQL.
- Human-in-the-loop (Founder AIS: `MCORE-FDR-AIS-001`) for production authorization.
