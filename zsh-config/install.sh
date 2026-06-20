#!/bin/bash
# install.sh — zsh config (idempotent — only creates if missing)
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
DEST="${HOME}/.dotfiles/zsh-config"

echo "🌿  zsh config → ~/.dotfiles/zsh-config/"
mkdir -p "$DEST"

# Copy files only if they don't exist yet
for f in .zshrc .p10k.zsh npm-jf.zsh; do
  [ -f "$DIR/$f" ] || continue
  if [ -f "$DEST/$f" ]; then
    echo "   ${f} — already exists, skipped"
  else
    cp "$DIR/$f" "$DEST/$f"
    echo "   ${f} — installed"
  fi
done

# Symlink .zshrc (only if not already pointing here)
if [ "$(readlink "${HOME}/.zshrc" 2>/dev/null)" != "$DEST/.zshrc" ]; then
  [ -L "${HOME}/.zshrc" ] && rm "${HOME}/.zshrc"
  [ -e "${HOME}/.zshrc" ] && mv "${HOME}/.zshrc" "${HOME}/.zshrc.bak-$(date +%Y%m%d-%H%M%S)"
  ln -sf "$DEST/.zshrc" "${HOME}/.zshrc"
  echo "   .zshrc — symlinked"
else
  echo "   .zshrc — already linked"
fi
