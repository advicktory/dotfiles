#!/bin/bash
# install.sh — moss dotfiles aggregator
# ./install.sh nvim|kitty|zsh|pi|all|extras
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
MODE="${1:-all}"

install_one() {
  local name="$1"
  local installer="${DIR}/${name}-config/install.sh"
  if [ -f "$installer" ]; then
    echo "  ${name} — using bundled files"
    bash "$installer"
  else
    echo "  ✗ ${name} — installer not found"
  fi
}

case "${MODE}" in
  nvim|kitty|zsh|pi) install_one "$MODE" ;;
  all)
    install_one nvim
    install_one kitty
    install_one zsh
    install_one pi
    ;;
  extras)
    for app in sketchybar aerospace yabai skhd karabiner; do
      src="${DIR}/app-configs/${app}"
      [ -d "$src" ] || continue
      echo "  ${app} → ~/.config/${app}"
      mkdir -p "${HOME}/.config"
      [ -L "${HOME}/.config/${app}" ] && rm "${HOME}/.config/${app}"
      ln -sf "$src" "${HOME}/.config/${app}"
    done
    ;;
  *) echo "Usage: ./install.sh [nvim|kitty|zsh|pi|all|extras]" ;;
esac
echo "✅  Done."
