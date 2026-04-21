# AGENTS.md - Neovim Configuration Guidelines

This Neovim config is a Lua-based setup built around `lazy.nvim`.

## Working Rules

- Keep changes small and local to the relevant module.
- Prefer built-in Neovim features over new plugins unless the repo already uses a plugin for that job.
- Check for existing formatter, LSP, or autocmd behavior before adding overlapping logic.
- Use `vim.keymap.set` with a `desc` for keymaps.
- Use snake_case for Lua locals, functions, and file names.
- Add comments only when the logic is non-obvious.

## Current Layout

```text
.config/nvim/
├── init.lua
├── lazy-lock.json
├── lua/
│   ├── base.lua
│   ├── config/
│   │   ├── autosave.lua
│   │   ├── keymaps.lua
│   │   └── lazy.lua
│   └── plugins/
│       ├── ai/
│       ├── completion/
│       ├── editing/
│       ├── git/
│       ├── language/
│       ├── navigation/
│       ├── ui/
│       └── workspace/
└── AGENTS.md
```

## Formatting And Save Behavior

- Formatting is handled by `stevearc/conform.nvim` in `lua/plugins/language/conform.lua`.
- `format_on_save` is controlled by `vim.g.format_on_save_enabled`.
- Lua formatting uses `stylua`.
- External formatter binaries are expected to come from Mason, and `base.lua` prepends Mason's `bin` directory to `PATH`.
- Autosave is implemented in `lua/config/autosave.lua`.
- Autosave currently runs on `FocusLost` and saves the current modified file buffer.
- Avoid reintroducing `lsp-format.nvim` or any second formatting-on-save path unless the user explicitly wants overlapping behavior.

## Common Workflows

- **Directory Sync on Exit**: The shell alias `n` (in `.zshrc`) is configured to `cd` to the last directory visited in Neovim upon exit. This is achieved by Neovim writing to `~/.nvim_last_dir`.
- **Plugin Management**: Use `:Lazy` to manage plugins. Use `:Lazy sync` to update everything.
- **LSP/Formatters**: Use `:Mason` to install or update language servers, formatters, and linters.

## Testing

Run from `.config/nvim/` when possible.

```bash
# Syntax check specific files
luac -p init.lua lua/base.lua lua/config/autosave.lua lua/config/keymaps.lua

# Minimal config load with writable cache/state paths
# Useful for verifying that plugins can load headlessly
XDG_CACHE_HOME=/tmp XDG_STATE_HOME=/tmp nvim --headless '+lua require("config.autosave").setup()' '+lua require("config.lazy")' '+qa'
```

## Validation Notes

- Headless Neovim may fail in sandboxed environments if it tries to write to the normal cache or state directories.
- If startup touches plugin caches, redirect `XDG_CACHE_HOME` and `XDG_STATE_HOME` to `/tmp`.
- Do not commit `.nvimlog` unless the user explicitly asks for debug logs.
- Update `lazy-lock.json` only when plugin versions actually change.

## Git Hygiene

- Do not revert unrelated user changes.
- Avoid committing generated files unless they are intentional.
- Keep plugin lockfile changes separate from config behavior changes when practical.

## Dotfiles Stow

After modifying any file in this directory, run `stow -R .` from the Dotfiles root to apply changes:
```bash
cd ~/Dotfiles && stow -R .
```
