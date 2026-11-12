# mcore-sboxdrive
### Unified Session Artifact Drive & Multi-Project Development Sandbox
**MCORE AIS/BOX-1.0 | Sovereign Autonomous Intelligence Infrastructure (SAII)**

---

## 1. Overview
**mcore-sboxdrive** is an isolated root-level environment (`/mcore-sboxdrive`) serving as the central storage and verification drive for MCore development projects. It organizes canonical session artifacts, multi-project development repositories, and research data collected from external Web AIs (DeepSeek, Gemini, Claude, ChatGPT).

## 2. Key Architecture Pillars
1. **Isolated Root Environment:** Resides at `/mcore-sboxdrive` with non-destructive separation from active `/srv` production services.
2. **Canonical Session Artifacts:** Retains and versions all master governance, security, and migration dossiers (`docs/canonical/`).
3. **Multi-Project Workspace:** Standardized project structure starting with **Project-A: NetProof360** (`projects/project-A-NetProof360/`).
4. **Web AI Knowledge Ingestion:** Tracks data and heuristics imported from external AIs (`DEEPSEEK_RESEARCH_INGEST.md`).
5. **Deterministic Manifest Automation:** Includes `scripts/generate-manifest.sh` to generate cryptographic SHA-256 inventories (`MANIFEST.md`, `manifest.json`) and portable ZIP archives.

## 3. Directory Layout
```text
/mcore-sboxdrive/
├── README.md                          # Repository overview and quickstart guide
├── MANIFEST.md                        # Cryptographically verified artifact catalog
├── manifest.json                      # Machine-readable JSON manifest
├── .gitignore                         # Standard git ignore definitions
├── docs/
│   ├── ARTIFACT_INVENTORY.md          # Complete File | Purpose inventory table
│   ├── UNIFIED_DRIVE_SPECIFICATION.md # Architecture specification for unified drive
│   └── canonical/                     # Canonical workspace dossiers & state files
│       ├── SAII_2050_EXECUTION_BASELINE.md
│       ├── MCORE_EXECUTIVE_SUMMARY_AND_PLATFORM_AUDIT.md
│       ├── MCORE_STARTUP_SECURITY_GOVERNANCE_DOSSIER.md
│       ├── MCORE_STARTUP_MIGRATION_AND_VERTEX_AI_STRATEGY.md
│       ├── DAILY_WORK_CONFIRMATION_2026-11-12.md
│       ├── AIS_MCORE_SUCCESS_CHRONICLE.md
│       ├── MCORE-DOCS-001.md
│       └── mcore-state.yaml
├── projects/
│   └── project-A-NetProof360/         # Project-A: Autonomous Network Proof
│       ├── README.md                  # Project mission and quickstart
│       ├── ARCHITECTURE.md            # 4-layer network verification pipeline
│       ├── config/
│       │   └── netproof.config.yaml   # Engine thresholds and probe targets
│       ├── docs/
│       │   ├── THREAT_MODEL.md        # STRIDE & SAII network security matrix
│       │   └── DEEPSEEK_RESEARCH_INGEST.md # Ingest log from DeepSeek AI
│       ├── evidence/                  # Generated telemetry snapshots & proofs
│       └── src/
│           ├── collector.py           # Synthetic probe and route hash collector
│           ├── verifier.py            # Zero-trust network attestation engine
│           └── manifest_hook.py       # Manifest export hook
├── scripts/
│   ├── generate-manifest.sh           # Manifest generator & ZIP packager
│   └── package-zip.sh                 # Distribution archive builder
└── dist/
    └── mcore-sboxdrive.zip            # Self-contained portable ZIP distribution
```

## 4. Quickstart Execution

### Generate Manifest & Package ZIP:
```bash
cd /mcore-sboxdrive
bash scripts/generate-manifest.sh
```

### Run Project-A NetProof360:
```bash
cd /mcore-sboxdrive/projects/project-A-NetProof360
python3 src/collector.py
python3 src/verifier.py
```

## 5. Governance & Repository Sync
- **Founder & Final Authority:** Aminul Islam Shamim (AIS) | ID: `MCORE-FDR-AIS-001`
- **GitHub Remote:** `git@github.com:aminul-du/mcore-sboxdrive.git` (Branch: `main`)
- **Doctrines:** Zero-Cost Strategy, Platform Lock & Non-Destructive Integrity.
