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
brew install stow tmux bash ruby reattach-to-user-namespace
brew install urlview wget neovim fzf zoxide
brew install ripgrep pngpaste git node jesseduffield/lazygit/lazygit
brew install yarn fd catimg git-flow cmake
brew install make gcc gh tidy-html5 curl
brew install tree-sitter atuin npm nvm pnpm
brew install grep aria2 ffmpeg yt-dlp eza
brew install difftastic zsh yazi ffmpegthumbnailer unar
brew install jq poppler font-symbols-only-nerd-font glow
brew install exiftool ouch --cask font-fira-code-nerd-font imagemagick
brew install bat btop
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

