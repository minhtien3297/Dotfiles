# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export LANG="en_US.UTF-8"
export MANPATH="/usr/local/man${MANPATH:+:$MANPATH}"
export NVM_DIR="$HOME/.nvm"

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

typeset -U path fpath

for dir in \
  /opt/homebrew/bin \
  /opt/homebrew/sbin \
  "$HOME/.antigravity/antigravity/bin"
do
  [[ -d "$dir" ]] && path=("$dir" $path)
done

for dir in \
  "$HOME/.docker/completions" \
  "${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-completions/src"
do
  [[ -d "$dir" ]] && fpath=("$dir" $fpath)
done

plugins=(
  zoxide
  starship
  fzf-tab
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-completions
)

source_if_exists() {
  [[ -r "$1" ]] && source "$1"
}

source "$ZSH/oh-my-zsh.sh"

bindkey -e
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':fzf-tab:*' popup-min-size 80 12
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -l --icons --git --all --no-filesize --no-time --no-user --no-permissions --color=always $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -l --icons --git --all --no-filesize --no-time --no-user --no-permissions --color=always $realpath'
zstyle ':fzf-tab:complete:z:*' popup-pad 30 0
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no

alias n='nvim'
alias t='tmux'
alias l='lg'
alias d='lazydocker'
alias c='clear'
alias ls='eza -l --icons --git -a --no-user --no-permissions'
alias upt='brew update && brew upgrade && brew cleanup && clear'
alias zshrc='source ~/.zshrc'
alias python='/usr/bin/python3'
alias -- run='~/run_project.sh'
alias -- sa='eval $(ssh-agent -s) && ~/ssh-add.sh ~/.ssh/id_rsa'
alias -- saw='eval $(ssh-agent -s) && ~/ssh-add.sh ~/.ssh/id_ed25519'

lg() {
  local new_dir_file="$HOME/.lazygit/newdir"

  export LAZYGIT_NEW_DIR_FILE="$new_dir_file"
  lazygit "$@"

  if [[ -f "$new_dir_file" ]]; then
    local new_dir
    new_dir="$(<"$new_dir_file")"
    [[ -n "$new_dir" ]] && builtin cd -- "$new_dir"
    rm -f -- "$new_dir_file"
  fi
}

y() {
  local tmp cwd

  tmp="$(mktemp -t yazi-cwd.XXXXXX)" || return
  command yazi "$@" --cwd-file="$tmp"
  cwd="$(<"$tmp")"
  [[ -n "$cwd" && "$cwd" != "$PWD" ]] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

if command -v ngrok >/dev/null 2>&1; then
  eval "$(ngrok completion)"
fi

if [[ -o interactive && -t 0 ]]; then
  if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init zsh)"
  fi

  if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
  fi
fi

source_if_exists "$HOME/.atuin/bin/env"
source_if_exists "$HOME/.local/bin/env"

if command -v mole >/dev/null 2>&1; then
  eval "$(mole completion zsh 2>/dev/null)"
fi

load_nvm() {
  unfunction nvm node npm npx pnpm yarn 2>/dev/null
  source_if_exists "$NVM_DIR/nvm.sh"
  source_if_exists "$NVM_DIR/bash_completion"
}

for cmd in nvm node npm npx pnpm yarn; do
  eval "${cmd}() { load_nvm; ${cmd} \"\$@\"; }"
done
