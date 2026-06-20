# ~/.npm-jf.zsh — auto-discover JFrog servers + npm fallback
_jf_ids=($(jf c show 2>/dev/null | awk '/Server ID:/ {print $NF}'))
: ${JF_STANDARD:=${_jf_ids[1]}}
: ${JF_ADMIN:=${_jf_ids[2]}}

npm() {
  case "$1" in
    install|i|add)
      jf npm "$@" --server-id="${JF_STANDARD:-default}" 2>/dev/null ||
      jf npm "$@" --server-id="${JF_ADMIN:-default}"
      ;;
    *) command npm "$@" ;;
  esac
}
