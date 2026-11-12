# MCore Unified SBoxDrive Specification
### Isolated Root Storage & Multi-Project Development Architecture

---

## 1. Context & Motivation
As MCore advances its SAII 2050 agenda, development sessions utilize multiple heterogeneous AI agents and web-based models (DeepSeek, Gemini, ChatGPT, Claude). To avoid fragmented codebases, lost session artifacts, or conflicting repository structures, **SBoxDrive** (`/mcore-sboxdrive`) provides a unified, isolated, and cryptographically verified environment under root.

## 2. Directory Hierarchy Standard
Every project under SBoxDrive adheres to this uniform layout:
```text
/mcore-sboxdrive/
├── .gitignore
├── README.md                          # Drive Overview & Multi-Project Index
├── MANIFEST.md                        # Auto-generated cryptographic catalog
├── manifest.json                      # Machine-readable JSON manifest
├── docs/
│   ├── ARTIFACT_INVENTORY.md          # Master File | Purpose documentation
│   ├── UNIFIED_DRIVE_SPECIFICATION.md # This specification document
│   └── canonical/                     # Canonical workspace and session files
├── projects/
│   ├── project-A-NetProof360/         # Project-A: Autonomous Network Proof
│   ├── project-B-<Name>/              # Future Project B
│   └── project-C-<Name>/              # Future Project C
├── scripts/
│   ├── generate-manifest.sh           # Manifest generator & ZIP packager
│   └── package-zip.sh                 # Distribution archive builder
└── dist/
    └── mcore-sboxdrive.zip            # Consolidated portable archive
```

## 3. Project Scaffolding Invariant
When initializing a new project (e.g., `projects/project-B-...`):
1. **`README.md`**: Must declare the project mission, SAII plane mapping, and founder authority (`MCORE-FDR-AIS-001`).
2. **`config/`**: Must contain declarative YAML/JSON configuration files with environment isolation.
3. **`docs/`**: Must include a threat model and external AI research ingestion log (`DEEPSEEK_RESEARCH_INGEST.md`).
4. **`src/`**: Modular, typed, production-quality Python or TypeScript code.
5. **`manifest_hook.py`**: Integration hook reporting relative paths and checksums.

## 4. Manifest & Integrity Enforcement
All artifacts within SBoxDrive are tracked via SHA-256 signatures. The script `scripts/generate-manifest.sh`:
- Runs deterministically across Linux/WSL environments.
- Automatically updates `MANIFEST.md` and `manifest.json`.
- Compresses verified assets into `dist/mcore-sboxdrive.zip`.
- Prepares git commit payloads for pushing to `git@github.com:aminul-du/mcore-sboxdrive.git`.
