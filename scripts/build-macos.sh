#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")/.."

BINARIES="${ELEMENTUM_BINARIES:-$HOME/Documents/elementum-binaries}"
PLATFORM="${ELEMENTUM_PLATFORM:-darwin_x64}"
TARGET="${ELEMENTUM_TARGET:-dist}"

if [[ ! -d "$BINARIES/$PLATFORM" ]]; then
    echo "Binari non trovati: $BINARIES/$PLATFORM"
    echo ""
    echo "Opzioni:"
    echo "  1. Compila: cd ~/Documents/elementum && make darwin-x64 darwin-x64-shared"
    echo "     Poi: ELEMENTUM_BINARIES=~/Documents/elementum/build ./scripts/build-macos.sh"
    echo "  2. Scarica sparse clone di elementum-binaries (solo darwin_x64)"
    exit 1
fi

chmod +x bundle.sh
./bundle.sh --binaries="$BINARIES" --platform="$PLATFORM" --target="$TARGET"

echo ""
ls -lh "$TARGET"/*.darwin_x64.zip 2>/dev/null || ls -lh "$TARGET"/*.zip
