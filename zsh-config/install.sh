#!/bin/bash
# install.sh — zsh config (standalone)
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
DEST="${HOME}/.dotfiles/zsh-config"

echo "🌿  zsh config → ~/.dotfiles/zsh-config/"
mkdir -p "$DEST"
cp "$DIR"/.zshrc "$DIR"/.p10k.zsh "$DEST/" 2>/dev/null || true
cp "$DIR"/npm-jf.zsh "$DEST/" 2>/dev/null || true

# Symlink .zshrc from permanent location
[ -L "${HOME}/.zshrc" ] && rm "${HOME}/.zshrc"
[ -e "${HOME}/.zshrc" ] && mv "${HOME}/.zshrc" "${HOME}/.zshrc.bak-$(date +%Y%m%d-%H%M%S)"
ln -sf "$DEST/.zshrc" "${HOME}/.zshrc"
echo "   done"
