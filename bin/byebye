#!/usr/bin/env bash
set -Eeuo pipefail # https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail

# ------------------------------------------------------------------------------
# --- Remove files safely ------------------------------------------------------
# ------------------------------------------------------------------------------

byebye-remove() {
  trash-put "$@"
}

byebye-forever() {
  trash-list |
    sort --reverse |
    fzf --border-label='Remove Forever' |
    sed 's/^[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\} [0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\} //' |
    xargs -I {} trash-rm {}
}

byebye-restore() {
  trash-restore
}

byebye-list() {
  trash-list | fzf
}

default() {
  echo '
    Usage:
      byebye remove [files]      use trash-put to remove files
      byebye restore             use trash-restore to restore files
      byebye list                list files in trash (list with fzf)
      byebye forever             remove files forever (choose with fzf)
  '
  exit 1
}

if [ $# -eq 0 ]; then
  default
else
  case "$1" in
    remove)
      if [ $# -eq 1 ]; then
        default
      else
        byebye-remove "${@:2}"
      fi
      ;;
    restore)
      byebye-restore
      ;;
    list)
      byebye-list
      ;;
    forever)
      byebye-forever
      ;;
    *)
      echo "TODO"
      exit 1
      ;;
  esac
fi
