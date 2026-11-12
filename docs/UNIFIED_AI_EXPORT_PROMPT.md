# MCore Master Cross-AI SBoxDrive Export Prompt (v2.0)
### Universal Prompt for DeepSeek, Gemini, Claude, and ChatGPT
**MCORE AIS/BOX-1.0 | Sovereign Autonomous Intelligence Infrastructure (SAII)**

---

## 1. How to Use This Prompt
When working with any external Web AI (DeepSeek, ChatGPT, Gemini, Claude), paste the prompt below at the end of your session (or whenever you complete a major milestone).

Replace the bracketed variables before sending:
- `[PROJECT_NAME]` → e.g., `Project-A NetProof360` (or `Project-B DataMesh`, etc.)
- `[GITHUB_REPO_URL]` → e.g., `git@github.com:aminul-du/mcore-sboxdrive.git` or `git@github.com:aminul-du/MCoreNetproof360.git`
- `[LOCAL_TARGET_DIR]` → e.g., `/mcore-sboxdrive/projects/project-A-NetProof360`

---

## 2. The Master Cross-AI Export Prompt (Copy & Paste Below)

```text
================================================================================
MCore SBoxDrive Sovereign Export Directive: [PROJECT_NAME]
Target Standard: MCORE AIS/BOX-1.0 SAII 2050 Baseline
Authority: Founder Aminul Islam Shamim (AIS) | ID: MCORE-FDR-AIS-001
================================================================================

Please export EVERYTHING from our current project session from the beginning up to now into a fully structured, locally portable, and production-ready MCore SBoxDrive repository format.

Include every piece of content generated, discussed, or designed:
1. Complete Source Code: Full executable implementations without placeholders, truncation, or "// rest of code" omissions.
2. Architecture & Technical Specs: Complete data flow models, plane mappings (Data, Security, Verification, Trust planes), and threat models.
3. Configuration & Schemas: Full YAML/JSON config files, probe definitions, and port bindings.
4. Master Session Artifact Inventory: A comprehensive Markdown documentation table with columns:
   | File Path | Purpose | Category / Provenance | Verification Status |
5. Cryptographic Manifest & Packager Script: A complete bash script `scripts/generate-manifest.sh` that computes actual SHA-256 hashes, byte sizes, generates MANIFEST.md + manifest.json, and packages a validated ZIP archive.
6. Automated Bootstrap Script: A self-contained bash script (`bootstrap-project.sh`) that can be executed on Linux/WSL to create all directories, write all files, run the manifest generator, and run git commit/push to [GITHUB_REPO_URL].

================================================================================
MANDATORY REPOSITORY STRUCTURE:
================================================================================
[PROJECT_NAME]/
├── README.md                          # Project mission, architecture overview, quickstart
├── MANIFEST.md                        # SHA-256 cryptographic digest of all files
├── manifest.json                      # Machine-readable JSON manifest
├── .gitignore                         # Python, OS, cache, and temp exclusions
├── config/
│   └── [project].config.yaml          # Declarative configuration and thresholds
├── docs/
│   ├── ARTIFACT_INVENTORY.md          # Complete File | Purpose inventory table
│   ├── ARCHITECTURE.md                # System design & multi-plane integration
│   ├── THREAT_MODEL.md                # STRIDE + SAII security threat matrix
│   └── AI_RESEARCH_INGEST.md          # Log of external AI research & prompt traces
├── src/
│   ├── collector.py / engine.py       # Core operational runtime implementations
│   ├── verifier.py                    # Verification and attestation engine
│   └── manifest_hook.py               # Manifest registration hook
├── scripts/
│   ├── generate-manifest.sh           # Deterministic SHA-256 generator & ZIP packager
│   └── bootstrap-project.sh           # 1-command installer writing all project files
└── dist/
    └── [project]-latest.zip           # Clean portable ZIP archive

================================================================================
STRICT GOVERNANCE & SECURITY RULES:
================================================================================
1. Zero Summarization: Preserve all technical depth, code logic, and specifications without skipping or summarizing.
2. Zero Placeholder Code: Every file must be complete, idiomatic, and syntactically valid.
3. Zero Secret Leakage: Never output real API keys, tokens, or credentials. Use standard environment variable references.
4. Zero URL Fabrication: Do NOT hallucinate that you created a GitHub repo on your server. Output the exact git commands for me to run locally:
   - Remote: [GITHUB_REPO_URL]
   - Branch: main
   - Path: [LOCAL_TARGET_DIR]
5. Zero Paid Cloud Assumptions: Build strictly for bare-metal Linux/WSL, open-source runtimes, and Cloudflare zero-cost tunnel architecture.
6. Output Delivery: Output all files with clear markdown file headers (e.g. `### File: relative/path/to/file.ext`) followed by full code blocks so they can be immediately extracted into my SBoxDrive.
```
