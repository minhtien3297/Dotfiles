[[ $- != *i* ]] && return

source_if_exists() {
  [[ -r "$1" ]] && . "$1"
}

if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init bash)"
  source_if_exists "$HOME/.atuin/bin/env"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --bash)"
fi

source_if_exists "$HOME/.local/bin/env"
