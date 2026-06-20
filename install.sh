#!/bin/bash
# install.sh — zsh config (standalone, no brew/nix needed)
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🌿  zsh config → ~/.zshrc"
[ -L "${HOME}/.zshrc" ] && rm "${HOME}/.zshrc"
[ -e "${HOME}/.zshrc" ] && mv "${HOME}/.zshrc" "${HOME}/.zshrc.bak-$(date +%Y%m%d-%H%M%S)"
ln -sf "$DIR/.zshrc" "${HOME}/.zshrc"
echo "   done"
