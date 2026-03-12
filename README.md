# Dotfiles Setup

Quick setup for macOS development environment.

## 1. Core Prerequisites

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Oh My Zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install TPM (tmux plugin manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## 2. Install Packages

```bash
# Install all formulae
brew install \
  stow tmux bash ruby reattach-to-user-namespace \
  urlview wget neovim fzf zoxide ripgrep pngpaste git node \
  jesseduffield/lazygit/lazygit yarn fd catimg git-flow cmake \
  make gcc gh tidy-html5 curl tree-sitter atuin npm nvm pnpm \
  grep aria2 ffmpeg yt-dlp eza difftastic zsh yazi \
  ffmpegthumbnailer unar jq poppler glow exiftool ouch \
  imagemagick bat btop jesseduffield/lazydocker/lazydocker \
  mole uv

# Install Nerd Fonts (Casks)
brew install --cask \
  font-symbols-only-nerd-font \
  font-fira-code-nerd-font

# Mole Quick Launchers setup
curl -fsSL https://raw.githubusercontent.com/tw93/Mole/main/scripts/setup-quick-launchers.sh | bash
```

## 3. Apply Configuration

```bash
cd ~/Dotfiles
stow -R .
```

## 4. Maintenance

### Uninstall Neovim
```bash
rm -rf ~/.config/nvim && rm -rf ~/.local/share/nvim
```

