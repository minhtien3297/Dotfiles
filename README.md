# Install

1. Brew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Programs

```
brew install stow tmux bash ruby reattach-to-user-namespace urlview wget neovim fzf zoxide ripgrep pngpaste git node jesseduffield/lazygit/lazygit yarn fd catimg git-flow cmake make gcc gh tidy-html5 curl tree-sitter
```

3. tpm

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

4. FiraCode Nerd Font:

```
https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
```

# Config

```
z Dotfiles
stow --adopt .
```

# Uninstall nvim

```
rm -rf ~/.config/nvim && rm -rf ~/.local/share/nvim
```
