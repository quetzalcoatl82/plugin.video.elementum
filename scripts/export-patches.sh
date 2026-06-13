#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")/.."

if ! git show-ref --verify --quiet refs/heads/custom; then
    echo "Branch custom non trovato."
    exit 1
fi

count=$(git rev-list --count master..custom 2>/dev/null || echo 0)
if [[ "$count" -eq 0 ]]; then
    echo "Nessun commit su custom rispetto a master."
    exit 0
fi

rm -f patches/*.patch
mkdir -p patches
git format-patch master..custom -o patches/ --start-number=1

echo "Esportate $count patch in patches/"
