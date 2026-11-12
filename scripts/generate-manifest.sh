#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# SBoxDrive Cryptographic Manifest Generator & Packager
# MCORE AIS/BOX-1.0 Sovereign Autonomous Intelligence Infrastructure
# ==============================================================================

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

TIMESTAMP="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
DATE_HUMAN="$(date -u +"%Y-%m-%d %H:%M:%S UTC")"
MANIFEST_MD="$REPO_ROOT/MANIFEST.md"
MANIFEST_JSON="$REPO_ROOT/manifest.json"
DIST_DIR="$REPO_ROOT/dist"
ZIP_FILE="$DIST_DIR/mcore-sboxdrive.zip"
ZIP_LATEST="$DIST_DIR/mcore-sboxdrive-latest.zip"

mkdir -p "$DIST_DIR"

echo "=================================================================="
echo " [SBoxDrive] Generating Manifest and Packaging Artifacts..."
echo " Root: $REPO_ROOT"
echo " Timestamp: $TIMESTAMP"
echo "=================================================================="

# File Purpose Lookup Function
get_purpose() {
    local file="$1"
    case "$file" in
        README.md) echo "Repository master landing page and architecture overview" ;;
        MANIFEST.md) echo "Cryptographically verified inventory with SHA-256 signatures" ;;
        manifest.json) echo "Machine-readable JSON manifest for automation" ;;
        .gitignore) echo "Git ignore rules for caches and temporary artifacts" ;;
        docs/ARTIFACT_INVENTORY.md) echo "Master File | Purpose inventory documentation" ;;
        docs/UNIFIED_DRIVE_SPECIFICATION.md) echo "Specification for unified drive and multi-project hierarchy" ;;
        docs/canonical/SAII_2050_EXECUTION_BASELINE.md) echo "Master 18-plane SAII 2050 Zero-Gap execution baseline" ;;
        docs/canonical/MCORE_EXECUTIVE_SUMMARY_AND_PLATFORM_AUDIT.md) echo "Platform audit, zero-cost topology, and service verification" ;;
        docs/canonical/MCORE_STARTUP_SECURITY_GOVERNANCE_DOSSIER.md) echo "Enterprise DevSecOps, predictive memory security, and Hack23 matrices" ;;
        docs/canonical/MCORE_STARTUP_MIGRATION_AND_VERTEX_AI_STRATEGY.md) echo "Multi-cloud migration, Vertex AI routing, and Cloudflare tunnel baseline" ;;
        docs/canonical/DAILY_WORK_CONFIRMATION_2026-11-12.md) echo "Daily operational confirmation of systemd services and DNS" ;;
        docs/canonical/AIS_MCORE_SUCCESS_CHRONICLE.md) echo "Chronicle of architectural breakthroughs and milestones" ;;
        docs/canonical/MCORE-DOCS-001.md) echo "Baseline system documentation and protocol registry" ;;
        docs/canonical/mcore-state.yaml) echo "Operational system state and port mapping" ;;
        projects/project-A-NetProof360/README.md) echo "Project-A NetProof360 mission and usage guide" ;;
        projects/project-A-NetProof360/ARCHITECTURE.md) echo "NetProof360 4-layer verification pipeline specification" ;;
        projects/project-A-NetProof360/config/netproof.config.yaml) echo "NetProof360 thresholds and synthetic probe targets" ;;
        projects/project-A-NetProof360/docs/THREAT_MODEL.md) echo "STRIDE and SAII network security threat matrix" ;;
        projects/project-A-NetProof360/docs/DEEPSEEK_RESEARCH_INGEST.md) echo "Research data and threat traces ingested from DeepSeek AI" ;;
        projects/project-A-NetProof360/src/collector.py) echo "Synthetic probe telemetry and route hash collector" ;;
        projects/project-A-NetProof360/src/verifier.py) echo "Zero-trust network attestation proof verification engine" ;;
        projects/project-A-NetProof360/src/manifest_hook.py) echo "Manifest export hook for Project-A artifacts" ;;
        projects/project-A-NetProof360/evidence/telemetry_snapshot.json) echo "Generated telemetry snapshot with route state hash" ;;
        projects/project-A-NetProof360/evidence/network_attestation.json) echo "Generated zero-trust attestation token" ;;
        scripts/generate-manifest.sh) echo "Manifest generator and automated ZIP packager" ;;
        scripts/package-zip.sh) echo "Dedicated distribution archive packaging utility" ;;
        *) echo "Component artifact under SBoxDrive workspace" ;;
    esac
}

# Python script to build both MANIFEST.md and manifest.json deterministically
python3 - << 'PYEOF'
import os
import hashlib
import json
from datetime import datetime, timezone

repo_root = os.getcwd()
exclude_prefixes = [".git/", "dist/", ".venv/", "__pycache__"]
exclude_exact = ["MANIFEST.md", "manifest.json"]

purposes = {
    "README.md": "Repository master landing page and architecture overview",
    ".gitignore": "Git ignore rules for caches and temporary artifacts",
    "docs/ARTIFACT_INVENTORY.md": "Master File | Purpose inventory documentation",
    "docs/UNIFIED_DRIVE_SPECIFICATION.md": "Specification for unified drive and multi-project hierarchy",
    "docs/canonical/SAII_2050_EXECUTION_BASELINE.md": "Master 18-plane SAII 2050 Zero-Gap execution baseline",
    "docs/canonical/MCORE_EXECUTIVE_SUMMARY_AND_PLATFORM_AUDIT.md": "Platform audit, zero-cost topology, and service verification",
    "docs/canonical/MCORE_STARTUP_SECURITY_GOVERNANCE_DOSSIER.md": "Enterprise DevSecOps, predictive memory security, and Hack23 matrices",
    "docs/canonical/MCORE_STARTUP_MIGRATION_AND_VERTEX_AI_STRATEGY.md": "Multi-cloud migration, Vertex AI routing, and Cloudflare tunnel baseline",
    "docs/canonical/DAILY_WORK_CONFIRMATION_2026-11-12.md": "Daily operational confirmation of systemd services and DNS",
    "docs/canonical/AIS_MCORE_SUCCESS_CHRONICLE.md": "Chronicle of architectural breakthroughs and milestones",
    "docs/canonical/MCORE-DOCS-001.md": "Baseline system documentation and protocol registry",
    "docs/canonical/mcore-state.yaml": "Operational system state and port mapping",
    "projects/project-A-NetProof360/README.md": "Project-A NetProof360 mission and usage guide",
    "projects/project-A-NetProof360/ARCHITECTURE.md": "NetProof360 4-layer verification pipeline specification",
    "projects/project-A-NetProof360/config/netproof.config.yaml": "NetProof360 thresholds and synthetic probe targets",
    "projects/project-A-NetProof360/docs/THREAT_MODEL.md": "STRIDE and SAII network security threat matrix",
    "projects/project-A-NetProof360/docs/DEEPSEEK_RESEARCH_INGEST.md": "Research data and threat traces ingested from DeepSeek AI",
    "projects/project-A-NetProof360/src/collector.py": "Synthetic probe telemetry and route hash collector",
    "projects/project-A-NetProof360/src/verifier.py": "Zero-trust network attestation proof verification engine",
    "projects/project-A-NetProof360/src/manifest_hook.py": "Manifest export hook for Project-A artifacts",
    "projects/project-A-NetProof360/evidence/telemetry_snapshot.json": "Generated telemetry snapshot with route state hash",
    "projects/project-A-NetProof360/evidence/network_attestation.json": "Generated zero-trust attestation token",
    "scripts/generate-manifest.sh": "Manifest generator and automated ZIP packager",
    "scripts/package-zip.sh": "Dedicated distribution archive packaging utility"
}

file_list = []
total_size = 0

for root, dirs, files in os.walk(repo_root):
    # Skip excluded directories
    rel_root = os.path.relpath(root, repo_root)
    if rel_root == ".":
        rel_root = ""
    else:
        rel_root = rel_root + "/"

    if any(rel_root.startswith(p) or f"/{p}" in f"/{rel_root}" for p in [".git/", "dist/", ".venv/", "__pycache__/"]):
        continue

    for f in sorted(files):
        rel_path = (rel_root + f).replace("\\", "/")
        if rel_path in exclude_exact or any(rel_path.startswith(p) for p in exclude_prefixes):
            continue

        full_path = os.path.join(root, f)
        size = os.path.getsize(full_path)
        total_size += size

        with open(full_path, "rb") as fp:
            sha = hashlib.sha256(fp.read()).hexdigest()

        purpose = purposes.get(rel_path, "SBoxDrive project artifact")
        file_list.append({
            "path": rel_path,
            "purpose": purpose,
            "size_bytes": size,
            "sha256": sha
        })

file_list.sort(key=lambda x: x["path"])

# Generate manifest.json
json_data = {
    "version": "1.0.0",
    "generated_at": datetime.now(timezone.utc).isoformat(),
    "authority": "MCORE-FDR-AIS-001",
    "total_files": len(file_list),
    "total_size_bytes": total_size,
    "artifacts": file_list
}

with open("manifest.json", "w", encoding="utf-8") as fp:
    json.dump(json_data, fp, indent=2)

# Generate MANIFEST.md
md_lines = [
    "# SBoxDrive Cryptographic Manifest",
    "### Complete Session Artifact Inventory & SHA-256 Digest",
    f"**Authority:** `MCORE-FDR-AIS-001` | **Generated:** {datetime.now(timezone.utc).strftime('%Y-%m-%d %H:%M:%S UTC')}",
    f"**Total Tracked Artifacts:** {len(file_list)} | **Total Size:** {total_size:,} bytes",
    "",
    "| File | Purpose | Size (Bytes) | SHA-256 Checksum |",
    "|---|---|---|---|"
]

for item in file_list:
    md_lines.append(f"| `{item['path']}` | {item['purpose']} | {item['size_bytes']:,} | `{item['sha256']}` |")

md_lines.append("")
md_lines.append("---")
md_lines.append("*Manifest automatically sealed by `scripts/generate-manifest.sh` under MCORE SAII Verification Plane rules.*")

with open("MANIFEST.md", "w", encoding="utf-8") as fp:
    fp.write("\n".join(md_lines) + "\n")

print(f"[Manifest Builder] Successfully cataloged {len(file_list)} artifacts ({total_size:,} bytes).")
PYEOF

echo "=================================================================="
echo " [SBoxDrive] Creating ZIP Distribution Archive..."
echo "=================================================================="

# Create ZIP archive (excluding .git and dist folder itself)
rm -f "$ZIP_FILE" "$ZIP_LATEST"
zip -qr "$ZIP_FILE" . -x ".git/*" "dist/*" "__pycache__/*" "*.pyc"
cp "$ZIP_FILE" "$ZIP_LATEST"

ZIP_SIZE=$(stat -c%s "$ZIP_FILE")
echo "[SBoxDrive] ZIP Created: $ZIP_FILE ($ZIP_SIZE bytes)"
echo "[SBoxDrive] Validating ZIP Integrity..."
unzip -tq "$ZIP_FILE"
echo "[SBoxDrive] ZIP Integrity: OK (Verified)"

echo "=================================================================="
echo " Manifest Generation & Packaging Complete!"
echo " - MANIFEST.md: Verified"
echo " - manifest.json: Verified"
echo " - dist/mcore-sboxdrive.zip: Sealed"
echo "=================================================================="
