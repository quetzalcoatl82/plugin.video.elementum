#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")/.."

shopt -s nullglob
patches=(patches/*.patch)

if [[ ${#patches[@]} -eq 0 ]]; then
    echo "Nessuna patch in patches/. Aggiungi prima le patch o committa su custom."
    exit 1
fi

echo "==> Reset branch custom da master"
git checkout master
if git show-ref --verify --quiet refs/heads/custom; then
    git branch -D custom
fi
git checkout -b custom

echo "==> Applico patch"
git am "${patches[@]}"

echo "==> Branch custom ricreato. Push con:"
echo "    git push origin custom --force-with-lease"
