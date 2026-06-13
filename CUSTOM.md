# Fork personalizzato

Fork di [elgatito/plugin.video.elementum](https://github.com/elgatito/plugin.video.elementum) con patch locali.
Il maintainer originale non accetta più PR: le modifiche vivono solo qui.

## Branch

| Branch | Scopo |
|--------|-------|
| `master` | Specchio di upstream — solo merge da `upstream/master` |
| `custom` | Patch personali sopra `master` |

## Aggiungere una patch

```bash
git checkout custom
# ... modifica i file ...
git add -p
git commit -m "patch: descrizione breve"
./scripts/export-patches.sh   # salva in patches/
git push origin custom
```

## Aggiornare da upstream

```bash
./scripts/sync-upstream.sh
./scripts/build-macos.sh
```

Se il rebase fallisce:

```bash
# risolvi i conflitti, poi:
git rebase --continue

# oppure riparti da zero dalle patch salvate:
./scripts/reset-custom-from-patches.sh
```

## Build macOS

```bash
./scripts/build-macos.sh
# zip in dist/
```

Variabile opzionale per i binari:

```bash
ELEMENTUM_BINARIES=/path/to/binaries ./scripts/build-macos.sh
```

## Release

Dopo la build, crea una release sul fork con tag tipo `v0.1.113-custom1` e allega lo zip da `dist/`.

## Binari

Non usare `git submodule update` su `resources/bin` (~13 GB).
Usa binari precompilati in `elementum-binaries/` o compila da `/Users/federico/Documents/elementum`.

Patch al daemon Go vivono in `patches/elementum/`. Dopo averle applicate:

```bash
cd ~/Documents/elementum
git am patches/elementum/*.patch   # oppure cherry-pick dal branch custom
make darwin-x64 darwin-x64-shared
cp -R build/darwin_x64 ~/Documents/elementum-binaries/
cd ~/Documents/plugin.video.elementum
./scripts/build-macos.sh
```
