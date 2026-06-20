#!/bin/bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
OUT="/tmp/moss-bundle-$(date +%Y%m%d).tar.gz"
echo "🌿  bundling moss dotfiles..."
cd "$DIR"
TMP=$(mktemp -d)
trap "rm -rf $TMP" EXIT
mkdir -p "$TMP/moss-dotfiles"
for cfg in nvim kitty zsh pi; do
  [ -d "${cfg}-config" ] && cp -r "${cfg}-config" "$TMP/moss-dotfiles/" && rm -rf "$TMP/moss-dotfiles/${cfg}-config/.git"
done
cp install.sh Brewfile "$TMP/moss-dotfiles/" 2>/dev/null || true
cp -r app-configs "$TMP/moss-dotfiles/" 2>/dev/null || true
cd "$TMP" && tar czf "$OUT" moss-dotfiles/
ls -lh "$OUT"
