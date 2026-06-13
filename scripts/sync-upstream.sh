#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")/.."

echo "==> Fetch upstream"
git fetch upstream

echo "==> Aggiorna master"
git checkout master
git merge upstream/master
git push origin master

if ! git show-ref --verify --quiet refs/heads/custom; then
    echo "==> Branch custom non trovato, lo creo da master"
    git checkout -b custom
    git push -u origin custom
    exit 0
fi

echo "==> Rebase custom su master"
git checkout custom
if git rebase master; then
    git push origin custom --force-with-lease
    echo "==> Fatto"
else
    echo ""
    echo "Rebase fallito. Opzioni:"
    echo "  git rebase --continue          # dopo aver risolto i conflitti"
    echo "  git rebase --abort             # annulla"
    echo "  ./scripts/reset-custom-from-patches.sh   # riparti dalle patch in patches/"
    exit 1
fi
