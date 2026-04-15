# AGENTS.md - Dotfiles

macOS development environment managed via GNU Stow. Shell: Zsh + Oh My Zsh. Editor: Neovim (lazy.nvim). Terminal: Kitty. Multiplexer: Tmux.

## Working Rules

- Run `stow -R .` from repo root after modifying any file to apply changes.
- Do not add Brewfile, Makefile, or CI/CD — this repo is manual-only by design.
- Keep changes small and targeted to the relevant config file.
- Match existing patterns: snake_case in Lua, standard shell conventions in zsh/bash.
- Check for existing aliases/functions before adding new ones in `.zshrc`.
- Do not store API keys or secrets in plain text (see `.zshrc` line ~230 warning).

## Repository Layout

```text
Dotfiles/
├── .bashrc                    # Bash fallback shell
├── .gitconfig                 # Git config (difft, rebase, main branch)
├── .vimrc                     # Minimal vim config
├── .zshrc                     # Primary shell (Oh My Zsh, ~239 lines)
├── .ssh/config                # SSH configuration
├── run_project.sh             # Generic project runner (detects npm/pnpm/yarn)
├── README.md                  # Setup instructions
├── .config/
│   ├── nvim/                  # Neovim config (80+ Lua files) — has own AGENTS.md
│   ├── tmux/                  # Tmux config + TPM plugins
│   ├── kitty/                 # Kitty terminal config
│   ├── yazi/                  # Yazi file manager config
│   ├── bat/                   # Bat syntax theme
│   ├── gh/                    # GitHub CLI config
│   ├── atuin/                 # Shell history sync
│   ├── mole/                  # Mole quick launcher
│   ├── opencode/              # OpenCode CLI config
│   └── starship.toml          # Starship prompt (Catppuccin Mocha)
├── apps/                      # Static app backups (Raycast, Sofle, Tampermonkey, etc.)
├── Library/Application Support/
│   ├── lazydocker/config.yml
│   └── lazygit/config.yml + state.yml
└── tmux/plugins/              # 3rd-party TPM plugins (not dotfiles code)
```

## Key Commands

| Action | Command |
|---|---|
| Apply all changes | `stow -R .` (from repo root) |
| Update Neovim plugins | `:Lazy sync` inside nvim |
| Update Tmux plugins | `prefix + I` (default prefix: `Ctrl+Space`) |
| Update Brew packages | `upt` (alias for brew update/upgrade/cleanup) |
| Run a project | `run` or `~/run_project.sh` |

## Shell Conventions (.zshrc)

- **Plugin manager**: Oh My Zsh with plugins: zoxide, starship, fzf-tab, zsh-syntax-highlighting, zsh-autosuggestions, zsh-completions
- **Prompt**: Starship with Catppuccin Mocha palette
- **Conditional sourcing**: Uses `source_if_exists()` helper — follow this pattern for new additions
- **NVM**: Lazy-loaded — only invokes when nvm/node/npm/pnpm/yarn is called
- **Key aliases**: `n`=nvim, `t`=tmux, `l`=lazygit, `d`=lazydocker, `o`=opencode, `ls`=eza --icons

## Tmux (.config/tmux)

- **Prefix**: `Ctrl+Space`
- **Theme**: Catppuccin Mocha
- **Plugins**: tmux-resurrect, tmux-continuum (via TPM)
- **macOS**: Uses `reattach-to-user-namespace` for clipboard

## Git (.gitconfig)

- Default branch: `main`
- Pull strategy: rebase
- Diff tool: `difftastic`
- `rerere.enabled = true`

## Neovim (.config/nvim)

Has its own **AGENTS.md** with detailed rules. Key points:
- **Plugin manager**: lazy.nvim
- **Formatter**: conform.nvim + stylua (Lua), Mason for LSP binaries
- **Autosave**: FocusLost via `lua/config/autosave.lua`
- **Structure**: `lua/plugins/` organized by category (ai, completion, editing, git, language, navigation, ui, workspace)

## apps/ Directory

Static application data and backups. Not code — do not generate AGENTS.md here. Contains:
- Raycast scripts/config
- Sofle keyboard layout
- Tampermonkey userscripts
- Vimium/SponsorBlock configs
