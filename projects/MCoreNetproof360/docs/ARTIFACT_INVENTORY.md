# Master Session Artifact Inventory

| File Path | Purpose | Category / Provenance | Verification Status |
|---|---|---|---|
| `README.md` | Project overview | Documentation | VERIFIED |
| `MANIFEST.md` | SHA-256 digest | Integrity | VERIFIED |
| `manifest.json` | Machine-readable manifest | Integrity | VERIFIED |
| `.gitignore` | Git exclusions | Configuration | VERIFIED |
| `.env.example` | Environment variable template | Configuration | VERIFIED |
| `config/netproof.config.yaml` | Declarative service & zone config | Configuration | VERIFIED |
| `config/services.json` | Measurement probe service definitions | Configuration | VERIFIED |
| `docs/ARCHITECTURE.md` | System design & plane integration | Documentation | VERIFIED |
| `docs/THREAT_MODEL.md` | STRIDE security matrix | Documentation | VERIFIED |
| `docs/AI_RESEARCH_INGEST.md` | AI prompt traces & research scope | Documentation | VERIFIED |
| `src/collector.py` | Python measurement engine & probe | Source Code | VERIFIED |
| `src/verifier.py` | Python Zero-Gap L1-L7 monitor | Source Code | VERIFIED |
| `src/manifest_hook.py` | Manifest registration hook | Source Code | VERIFIED |
| `src/web/mcore-monitor-3d.html` | Three.js 3D Operational Dashboard | Source Code | VERIFIED |
| `src/rust/Cargo.toml` | Rust workspace definition | Source Code | VERIFIED |
| `src/rust/crates/measurement/Cargo.toml` | Measurement crate dependencies | Source Code | VERIFIED |
| `src/rust/crates/measurement/src/main.rs` | Rust probe with Tokio & SQLx | Source Code | VERIFIED |
| `src/rust/apps/api/Cargo.toml` | Axum API crate dependencies | Source Code | VERIFIED |
| `src/rust/apps/api/src/main.rs` | Rust Axum REST control plane | Source Code | VERIFIED |
| `src/rust/migrations/20231112000000_init.sql` | PostgreSQL pgvector schema | Source Code | VERIFIED |
| `scripts/generate-manifest.sh` | SHA-256 & ZIP packager | Script | VERIFIED |
| `scripts/bootstrap-project.sh` | 1-click bootstrap installer | Script | VERIFIED |
| `dist/MCoreNetproof360-latest.zip`| Portable archive | Distribution | VERIFIED |
