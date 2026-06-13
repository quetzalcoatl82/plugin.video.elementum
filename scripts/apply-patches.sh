#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")/.."

shopt -s nullglob
patches=(patches/*.patch)

if [[ ${#patches[@]} -eq 0 ]]; then
    echo "Nessuna patch in patches/"
    exit 0
fi

echo "==> Applico ${#patches[@]} patch"
git am "${patches[@]}"
