#!/bin/bash
set -euo pipefail

ZIP="${1:-}"
ADDON_DIR="$HOME/Library/Application Support/Kodi/addons"
TARGET="$ADDON_DIR/plugin.video.elementum"

if [[ -z "$ZIP" ]]; then
    ZIP="$(ls -t "$(dirname "$0")/../dist"/*.darwin_x64.zip 2>/dev/null | head -1)"
fi

if [[ ! -f "$ZIP" ]]; then
    echo "Zip non trovato: $ZIP"
    exit 1
fi

if pgrep -x Kodi >/dev/null 2>&1; then
    echo "Chiudi Kodi completamente prima di installare."
    echo "Kodi è ancora in esecuzione."
    exit 1
fi

echo "Installazione da: $ZIP"
rm -rf "$TARGET"
mkdir -p "$ADDON_DIR"
unzip -o "$ZIP" -d "$ADDON_DIR"
chmod +x "$TARGET/resources/bin/darwin_x64/"* 2>/dev/null || true

echo "Installato in: $TARGET"
echo "Versione addon: $(grep -m1 'version=' "$TARGET/addon.xml" | sed 's/.*version=\"\\([^\"]*\\)\".*/\\1/')"
echo "Versione daemon: $(cat "$TARGET/resources/bin/darwin_x64/version" 2>/dev/null || echo n/d)"
