
#!/usr/bin/env zsh
#
# ~/.zshrc - Zsh configuration file
#
# This file is sourced by interactive zsh shells for configuration.
# Last updated: $(date +%Y-%m-%d) - Refactored for organization and security
#
# ------------------------------------------------------------------------------
# 1. ENVIRONMENT VARIABLES
# ------------------------------------------------------------------------------

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export LANG="en_US.UTF-8"
export MANPATH="/usr/local/man${MANPATH:+:$MANPATH}"
export NVM_DIR="$HOME/.nvm"

# ------------------------------------------------------------------------------
# 2. OH MY ZSH SETTINGS
# ------------------------------------------------------------------------------

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# OpenCode settings
export OMO_SEND_ANONYMOUS_TELEMETRY=0

# ------------------------------------------------------------------------------
# 3. PATH AND FPATH SETUP
# ------------------------------------------------------------------------------

typeset -U path fpath  # Ensure unique entries in PATH and fpath

# Add directories to PATH if they exist
for dir in \
  /opt/homebrew/bin \
  /opt/homebrew/sbin \
  "$HOME/.antigravity/antigravity/bin" \
  "$HOME/.bun/bin" \
  "$HOME/.opencode/bin"
do
  [[ -d "$dir" ]] && path=("$dir" $path)
done

# Add completion directories to fpath
for dir in \
  "$HOME/.docker/completions" \
  "${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-completions/src"
do
  [[ -d "$dir" ]] && fpath=("$dir" $fpath)
done

# ------------------------------------------------------------------------------
# 4. PLUGINS
# ------------------------------------------------------------------------------

plugins=(
  zoxide
  starship
  fzf-tab
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-completions
)

# ------------------------------------------------------------------------------
# 5. HELPER FUNCTIONS
# ------------------------------------------------------------------------------

source_if_exists() {
  [[ -r "$1" ]] && source "$1"
}

# ------------------------------------------------------------------------------
# 6. OH MY ZSH INITIALIZATION
# ------------------------------------------------------------------------------

source "$ZSH/oh-my-zsh.sh"

# ------------------------------------------------------------------------------
# 7. KEY BINDINGS
# ------------------------------------------------------------------------------

bindkey -e
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# ------------------------------------------------------------------------------
# 8. HISTORY SETTINGS
# ------------------------------------------------------------------------------

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

# ------------------------------------------------------------------------------
# 9. COMPLETION STYLING
# ------------------------------------------------------------------------------

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

export EDITOR=nvim
export VISUAL=nvim

# ------------------------------------------------------------------------------
# 10. ALIASES
# ------------------------------------------------------------------------------

unalias n 2>/dev/null
n() {
  command nvim "$@"
  if [[ -f "$HOME/.nvim_last_dir" ]]; then
    cd "$(cat "$HOME/.nvim_last_dir")" 2>/dev/null
  fi
}
alias t='tmux'
alias l='lg'
alias d='lazydocker'
alias c='clear'
alias o='opencode'
alias ls='eza -l --icons --git -a --no-user --no-permissions'
alias upt='brew update && brew upgrade && brew cleanup && clear'
alias zshrc='source ~/.zshrc'
alias python='/usr/bin/python3'
alias -- run='~/run_project.sh'

# ------------------------------------------------------------------------------
# 11. FUNCTIONS
# ------------------------------------------------------------------------------

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

# ------------------------------------------------------------------------------
# 12. TOOL COMPLETIONS
# ------------------------------------------------------------------------------

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
source_if_exists "$HOME/Dotfiles/.env"

if command -v mole >/dev/null 2>&1; then
  eval "$(mole completion zsh 2>/dev/null)"
fi

# ------------------------------------------------------------------------------
# 13. NVM LAZY LOADING
# ------------------------------------------------------------------------------

load_nvm() {
  unfunction nvm node npm npx pnpm yarn 2>/dev/null
  source_if_exists "$NVM_DIR/nvm.sh"
  source_if_exists "$NVM_DIR/bash_completion"
}

# Lazy loading: Only load NVM when nvm/node/npm/etc commands are actually invoked
for cmd in nvm node npm npx pnpm yarn; do
  eval "${cmd}() { load_nvm; ${cmd} \"\$@\"; }"
done

# ------------------------------------------------------------------------------
# 14. PNPM PATH SETUP
# ------------------------------------------------------------------------------

# pnpm
export PNPM_HOME="/Users/daominhtien/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# ------------------------------------------------------------------------------
# 15. DOCKER SETUP
# ------------------------------------------------------------------------------

# Docker completions are already handled in the fpath setup section above
# End of Docker CLI completions
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/daominhtien/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

export _ZO_EXCLUDE_DIRS="node_modules .git target dist build cache __pycache__ *.egg-info /mnt /Volumes /net /media"

# Note: zoxide init is handled by Oh My Zsh plugin (see plugins array above)
# eval "$(zoxide init zsh)"  # <-- REMOVED to prevent duplicate hooks

# ------------------------------------------------------------------------------
# 16. ZF FILE-WORKFLOW HELPER
# ------------------------------------------------------------------------------


# Jump to the best directory for a given file path using zoxide.
# Usage: zf <file-path>
# Example: zf readme.md -> finds dirs containing readme.md via zoxide query
zf_old() {
  if [[ -z "$1" ]]; then
    echo "Usage: zf <file-path>"
    echo "Jump to the best directory for a file path using zoxide."
    return 1
  fi

  local file_path="$1"
  local dir

  # Extract directory from the file path
  dir=$(dirname "$file_path")

  # Use zoxide query to find the best matching directory
  local target
  target=$(zoxide query "$dir" 2>/dev/null)

  if [[ -n "$target" && -d "$target" ]]; then
    cd "$target"
  elif [[ -d "$dir" ]]; then # Fallback: if zoxide has no match, try to cd directly
    cd "$dir"
  else
    echo "zoxide: no match found for directory: $dir"
    return 1
  fi
}

# zf: Jump to directory containing a file (fast, no fzf)
# Usage: zf <file-name>
# Uses fd to find first match, then jumps to its directory.
zf() {
    if [[ -z "$1" ]]; then
        echo "Usage: zf <file-name-pattern>"
        echo "Finds a file using 'fd' and jumps to its directory (first match)."
        return 1
    fi

    local file
    # Find the file using fd, honoring .gitignore, and excluding common noise.
    file=$(fd --type f --hidden --exclude "{$_ZO_EXCLUDE_DIRS}" "$1" 2>/dev/null | head -1)

    if [[ -n "$file" ]]; then
        local dir
        dir=$(dirname "$file")
        if [[ -d "$dir" ]]; then
            cd "$dir"
        else
            echo "Error: Could not change to directory: $dir"
            return 1
        fi
    else
        echo "No file found matching: $1"
        return 1
    fi
}


# ------------------------------------------------------------------------------
# 16. ZOXIDE SCOPE HELPERS
# ------------------------------------------------------------------------------

zp() {
  local target="${1:-}"
  local dir=""

  if [[ -n "$target" ]]; then
    dir=$(zoxide query --base-dir ~/Projects "$target" 2>/dev/null)
    [[ -z "$dir" ]] && dir=$(zoxide query --base-dir ~/Documents "$target" 2>/dev/null)
    [[ -z "$dir" ]] && dir=$(zoxide query "$target" 2>/dev/null)
  else
    dir=$(zoxide query --base-dir ~/Projects 2>/dev/null)
    [[ -z "$dir" ]] && dir=$(zoxide query --base-dir ~/Documents 2>/dev/null)
    [[ -z "$dir" ]] && dir=$(zoxide query 2>/dev/null)
  fi

  if [[ -n "$dir" && -d "$dir" ]]; then
    cd "$dir"
  else
    [[ -n "$target" ]] && echo "zoxide: no match found for: $target" || echo "zoxide: no match found"
    return 1
  fi
}
alias zp_pj='cd ~/Projects'
alias zp_doc='cd ~/Documents'
