# Install

1. Brew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Oh My ZSH

```
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

3. Programs

```
brew install stow tmux bash ruby reattach-to-user-namespace urlview wget neovim fzf zoxide ripgrep pngpaste git node jesseduffield/lazygit/lazygit yarn fd catimg git-flow cmake make gcc gh tidy-html5 curl tree-sitter atuin npm nvm pnpm curl grep aria2 ffmpeg yt-dlpa eza difftastic zsh yazi ffmpegthumbnailer unar jq poppler font-symbols-only-nerd-font glow exiftool ouch --cask font-fira-code-nerd-font imagemagick bat
```

4. tpm

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

# Config

```
z Dotfiles
stow -R --adopt .
```

# Uninstall nvim

```
rm -rf ~/.config/nvim && rm -rf ~/.local/share/nvim
```

