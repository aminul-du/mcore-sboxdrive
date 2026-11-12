# Complete Session Artifact Inventory Documentation
### Unified SBoxDrive Catalog & Provenance Matrix
**MCORE AIS/BOX-1.0 | Sovereign Autonomous Intelligence Infrastructure**

---

## 1. Executive Mission of SBoxDrive
**mcore-sboxdrive** serves as the central, unified, and isolated repository under root (`/mcore-sboxdrive`) designed to:
1. Preserve and attest canonical architectural, security, and governance documentation generated across development sessions.
2. Host standardized project modules (starting with **Project-A: NetProof360**).
3. Provide a structured landing zone for data, heuristics, and research ingested from external Web AIs (DeepSeek, ChatGPT, Gemini, Claude).
4. Auto-generate cryptographic manifests (`MANIFEST.md`, `manifest.json`) and portable ZIP archives via `scripts/generate-manifest.sh`.

---

## 2. Master Session Artifact Inventory (`File | Purpose`)

| File Path | Purpose | Category / Provenance | Verification Status |
|---|---|---|---|
| `README.md` | Root landing page, architecture overview, project index, and quickstart commands | System Root / MCore | Active / Versioned |
| `MANIFEST.md` | Cryptographically signed inventory of all files with SHA-256 hashes and sizes | Auto-Generated / Core | Verified by Script |
| `manifest.json` | Machine-readable JSON artifact manifest for CI/CD and automated ingestion | Auto-Generated / CI | Verified by Script |
| `.gitignore` | Prevents byte-compiled files, caches, and OS artifacts from polluting git | Environment Config | Enforced |
| `docs/ARTIFACT_INVENTORY.md` | Master documentation catalog defining File and Purpose for all workspace assets | Documentation / AIS | Canonical Source |
| `docs/UNIFIED_DRIVE_SPECIFICATION.md` | Architecture specification for unified multi-project drive & Web AI data collection | Architecture Plane | Approved |
| `docs/canonical/SAII_2050_EXECUTION_BASELINE.md` | Sovereign Autonomous Intelligence Infrastructure 18-plane governance baseline | Canonical Workspace / AIS | Master Baseline |
| `docs/canonical/MCORE_EXECUTIVE_SUMMARY_AND_PLATFORM_AUDIT.md` | Executive platform audit, zero-cost bare-metal topology, and active systemd services | Canonical Workspace / Audit | Operational Attestation |
| `docs/canonical/MCORE_STARTUP_SECURITY_GOVERNANCE_DOSSIER.md` | Enterprise DevSecOps dossier, predictive memory security, and Hack23 risk matrices | Canonical Workspace / CISO | Audit-Defensible |
| `docs/canonical/MCORE_STARTUP_MIGRATION_AND_VERTEX_AI_STRATEGY.md` | Multi-cloud migration roadmap, Vertex AI routing, and zero-spend Cloudflare tunnel baseline | Canonical Workspace / Strategy | Approved |
| `docs/canonical/DAILY_WORK_CONFIRMATION_2026-11-12.md` | Immutable daily log of systemd microservice states, Cloudflare tunnels, and DNS mappings | Canonical Workspace / Daily Log | Signed by AIS |
| `docs/canonical/AIS_MCORE_SUCCESS_CHRONICLE.md` | Chronological record of architectural breakthroughs, academic gates, and milestones | Canonical Workspace / History | Historical Record |
| `docs/canonical/MCORE-DOCS-001.md` | Comprehensive system design, model gateway specifications, and protocol registry | Canonical Workspace / Technical | Baseline Doc |
| `docs/canonical/mcore-state.yaml` | System-wide operational state, active port bindings, and endpoint mapping | Canonical Workspace / State | Configuration Anchor |
| `projects/project-A-NetProof360/README.md` | Mission, overview, and usage instructions for autonomous network proof engine | Project-A / Core | Active Specification |
| `projects/project-A-NetProof360/ARCHITECTURE.md` | 4-layer network verification pipeline and multi-plane integration blueprint | Project-A / Architecture | Approved Design |
| `projects/project-A-NetProof360/config/netproof.config.yaml` | Thresholds, probe targets, and cryptographic settings for NetProof360 engine | Project-A / Config | Configured |
| `projects/project-A-NetProof360/docs/THREAT_MODEL.md` | STRIDE and SAII network attack surface, route poisoning, and mitigation invariants | Project-A / Security | Defensible Model |
| `projects/project-A-NetProof360/docs/DEEPSEEK_RESEARCH_INGEST.md` | Ingest log for algorithms, heuristics, and threat traces collected from DeepSeek AI | Project-A / Web AI Ingest | Validated Intake |
| `projects/project-A-NetProof360/src/collector.py` | Active synthetic probe collector measuring socket latency and computing route hashes | Project-A / Runtime Code | Executable Verified |
| `projects/project-A-NetProof360/src/verifier.py` | Zero-trust cryptographic verification engine emitting network attestation tokens | Project-A / Runtime Code | Executable Verified |
| `projects/project-A-NetProof360/src/manifest_hook.py` | Hook scanning project files and emitting SHA-256 signatures to SBoxDrive manifest | Project-A / Tooling | Executable Verified |
| `projects/project-A-NetProof360/evidence/telemetry_snapshot.json` | Real-time probe telemetry snapshot containing route state SHA-256 | Project-A / Evidence | Generated Live |
| `projects/project-A-NetProof360/evidence/network_attestation.json` | Cryptographic attestation token signed with MCORE-FDR-AIS-001 authority | Project-A / Evidence | Signed Attestation |
| `scripts/generate-manifest.sh` | Shell script generating MANIFEST.md, manifest.json, and packaging distribution ZIP | Automation / DevOps | Production Tested |
| `dist/mcore-sboxdrive.zip` | Standalone portable archive containing all canonical files and project code | Release Artifact | Validated ZIP |

---

## 3. Web AI Knowledge Collection Rules
When ingesting research from DeepSeek or other Web AI systems:
1. **Quarantine Phase:** New inputs are placed under `projects/<project>/docs/ingest/`.
2. **Attribution:** Document the prompt, query intent, source AI model, and session timestamp.
3. **Validation:** Review all algorithms against SAII 2050 Zero-Cost, Bare-Metal, and Non-Destructive Integrity doctrines before promoting into `src/`.
4. **Manifest Registration:** Run `bash scripts/generate-manifest.sh` to seal all new additions into the cryptographic manifest.
