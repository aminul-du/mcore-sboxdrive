#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

DIST_DIR="$REPO_ROOT/dist"
mkdir -p "$DIST_DIR"

OUTPUT_ZIP="$DIST_DIR/mcore-sboxdrive.zip"
LATEST_ZIP="$DIST_DIR/mcore-sboxdrive-latest.zip"

echo "[Packager] Building portable ZIP archive: $OUTPUT_ZIP"
rm -f "$OUTPUT_ZIP" "$LATEST_ZIP"
zip -qr "$OUTPUT_ZIP" . -x ".git/*" "dist/*" "__pycache__/*" "*.pyc"
cp "$OUTPUT_ZIP" "$LATEST_ZIP"

echo "[Packager] Archive size: $(stat -c%s "$OUTPUT_ZIP") bytes"
unzip -tq "$OUTPUT_ZIP"
echo "[Packager] Archive integrity verified successfully."
