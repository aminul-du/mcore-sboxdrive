#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "=================================================================="
echo "▶ [MCoreNetproof360] Generating MANIFEST.md and manifest.json..."
echo "=================================================================="

mkdir -p dist

# Start Markdown
cat > MANIFEST.md << 'EOF'
# MCoreNetproof360 Cryptographic Manifest (SHA-256)
**Authority:** `MCORE-FDR-AIS-001` | **Standard:** SAII 2050 Baseline

| File Path | SHA-256 Checksum | Size (Bytes) |
|---|---|---|
EOF

# Start JSON
cat > manifest.json << EOF
{
  "project": "MCoreNetproof360",
  "authority": "MCORE-FDR-AIS-001",
  "generated_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "files": [
EOF

FIRST=true
while IFS= read -r -d '' file; do
    rel_path="${file#./}"
    hash=$(sha256sum "$file" | awk '{print $1}')
    size=$(stat -c%s "$file")
    
    echo "| \`$rel_path\` | \`$hash\` | $size |" >> MANIFEST.md
    
    if [ "$FIRST" = true ]; then
        FIRST=false
    else
        echo "," >> manifest.json
    fi
    echo -n "    {\"path\": \"$rel_path\", \"sha256\": \"$hash\", \"size\": $size}" >> manifest.json

done < <(find . -type f ! -path './.git/*' ! -path './target/*' ! -path './node_modules/*' ! -path './dist/*' ! -name 'MANIFEST.md' ! -name 'manifest.json' ! -name '.env' -print0 | sort -z)

cat >> manifest.json << 'EOF'

  ]
}
EOF

echo "✅ Manifest generated successfully."

# Packaging
ZIP_OUT="dist/MCoreNetproof360-latest.zip"
echo "▶ Creating $ZIP_OUT..."
rm -f "$ZIP_OUT"
zip -qr "$ZIP_OUT" . \
    -x '.git/*' \
    -x 'target/*' \
    -x 'node_modules/*' \
    -x 'dist/*' \
    -x '.env' \
    -x '__pycache__/*' \
    -x '*.pyc'

echo "✅ Archive ready: $ZIP_OUT ($(stat -c%s "$ZIP_OUT") bytes)"
unzip -tq "$ZIP_OUT"
echo "✅ Archive verified: OK"
