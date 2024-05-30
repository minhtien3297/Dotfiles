# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 7

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
  starship
  zoxide
  fzf-tab
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-completions
)

# add zsh-completions path
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# User configuration
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Homebrew path
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
export PATH=/opt/homebrew/bin:$PATH

# Keybindings
bindkey -e
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling for fzf-tab, NOTE: run exec zsh to enable 
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -l --icons --git -a  --no-filesize --no-time --no-user --no-permissions --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# preview directory's content with eza when completing zoxide
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -l --icons --git -a  --no-filesize --no-time --no-user --no-permissions --color=always $realpath'
# using popup tmux feature
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

### alias
alias n='nvim'
alias t='tmux'
alias l='lg'
alias c='clear'
alias ls='eza -l --icons --git -a --no-user --no-permissions'
alias zshrc='source ~/.zshrc'
alias python=/usr/bin/python3

# alias functions
alias -- run='~/run_project.sh'
alias -- sa='eval $(ssh-agent -s) && ~/ssh-add.sh ~/.ssh/id_rsa'
alias -- saw='eval $(ssh-agent -s) && ~/ssh-add.sh ~/.ssh/id_ed25519'

# lazygit
lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}


eval "$(atuin init zsh)"
