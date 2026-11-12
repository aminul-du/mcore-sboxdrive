#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════
#  MCore SBoxDrive Sovereign Bootstrap
#  Target: MCORE AIS/BOX-1.0 SAII 2050 Baseline
#  Authority: Founder Aminul Islam Shamim (AIS) | MCORE-FDR-AIS-001
# ═══════════════════════════════════════════════════════════════════
set -euo pipefail

PROJECT_NAME="MCoreNetproof360"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
GITHUB_REPO="git@github.com:aminul-du/mcore-sboxdrive.git"

echo "▶ Bootstrapping $PROJECT_NAME at $PROJECT_DIR"
cd "$PROJECT_DIR"

# 1. Run Migrations on PostgreSQL
if command -v psql >/dev/null 2>&1; then
    echo "▶ Checking PostgreSQL database..."
    PGPASSWORD=mcoreai psql -U mcoreai -h localhost -d mcoreai -f src/rust/migrations/20231112000000_init.sql || true
fi

# 2. Run Measurement & Verifier
echo "▶ Running Python measurement plane probe..."
python3 src/collector.py
echo "▶ Running L1-L7 Zero-Gap verifier..."
python3 src/verifier.py

# 3. Generate Manifest and ZIP package
echo "▶ Generating Manifest & ZIP..."
bash scripts/generate-manifest.sh

echo "════════════════════════════════════════════════════════════════"
echo "  ✅ BOOTSTRAP VERIFICATION COMPLETE at $PROJECT_DIR"
echo "════════════════════════════════════════════════════════════════"
