# AGENTS.md - Neovim Configuration Guidelines

This document provides guidelines for AI agents working on this Neovim configuration codebase. The codebase is a Lua-based Neovim setup using lazy.nvim for plugin management.

## Build/Lint/Test Commands

### Testing the Configuration
Since this is a Neovim configuration (not a traditional application), "testing" involves verifying the config loads without errors:

```bash
# Test basic config loading (run from Neovim config directory)
cd ~/.config/nvim
nvim --headless -c "lua require('base')" -c "qa"

# Check for Lua syntax errors
luac -p lua/**/*.lua

# Validate lazy.nvim setup
nvim --headless -c "lua require('config.lazy')" -c "qa"
```

### Linting
```bash
# Install luacheck for linting (if not already installed)
brew install luarocks
luarocks install luacheck

# Run luacheck on all Lua files
luacheck lua/

# Run luacheck with specific config
luacheck --config .luarc.json lua/
```

### Formatting
```bash
# Install stylua for formatting
brew install stylua

# Format all Lua files
stylua lua/

# Check formatting without changing files
stylua --check lua/
```

### Running Single Tests
This codebase doesn't have traditional unit tests, but you can test individual plugin configurations:

```bash
# Test a specific plugin config (example)
nvim --headless -c "lua require('plugins.ui.catppuccin')" -c "qa"

# Test keymaps
nvim --headless -c "lua require('config.keymaps')" -c "qa"
```

## Code Style Guidelines

### Lua Style
- Use 2-space indentation (matches `vim.opt.tabstop = 2` in base.lua)
- Use `vim.opt` for setting options instead of `vim.o`
- Use `vim.keymap.set` for key mappings instead of legacy `vim.api.nvim_set_keymap`
- Use descriptive variable names in snake_case
- Add comments for complex logic or non-obvious code

### Plugin Organization
- Plugins are organized in `lua/plugins/` with subdirectories by category:
  - `ai/` - AI-related plugins
  - `completion/` - Auto-completion plugins
  - `editing/` - Text editing enhancements
  - `git/` - Git integration
  - `language/` - Language-specific plugins
  - `navigation/` - Navigation and search
  - `ui/` - User interface plugins
  - `workspace/` - Workspace management

### Plugin Configuration Structure
Follow this standard structure for plugin files:

```lua
return {
  "author/plugin-name",
  event = "VeryLazy",  -- or other lazy loading trigger
  dependencies = {
    "dependency1",
    "dependency2",
  },

  config = function()
    -- Plugin setup code here
    require("plugin").setup({
      -- options
    })
  end,
}
```

### Imports and Dependencies
- Use `local plugin = require("plugin")` for requiring modules
- Group related requires at the top of functions
- Use `pcall` for optional dependencies:

```lua
local status_ok, plugin = pcall(require, "optional-plugin")
if not status_ok then
  return
end
```

### Keymaps
- Use `<leader>` (space) as the primary leader key
- Use descriptive `desc` fields for all keymaps
- Group related keymaps with comments
- Follow the pattern: `<leader>{category}{action}`

### Error Handling
- Use `pcall` for operations that might fail
- Provide meaningful error messages
- Gracefully degrade when plugins are missing

### Naming Conventions
- **Files**: Use lowercase with underscores (snake_case) for Lua files
- **Variables**: Use snake_case for local variables
- **Functions**: Use snake_case for function names
- **Modules**: Use the file path as the module name

### Code Organization
- Keep plugin configurations modular and focused
- Separate core functionality (base.lua) from plugin-specific code
- Use consistent ordering: options, keymaps, autocmds, plugin setup

### Performance Considerations
- Use lazy loading for plugins with `event`, `cmd`, or `ft` triggers
- Disable unused built-in plugins in lazy.lua
- Cache expensive operations when possible
- Use `vim.defer_fn` for non-critical setup

### Documentation
- Add comments for complex configurations
- Document keymap purposes with `desc` fields
- Include setup instructions in comments when necessary

### Git Practices
- Commit plugin updates separately from configuration changes
- Use descriptive commit messages
- Test configuration changes before committing

### Testing Changes
- Always test keymaps after adding/modifying them
- Verify plugin configurations load without errors
- Check that lazy loading works as expected
- Test on both GUI and terminal Neovim

### Common Patterns

#### Conditional Plugin Loading
```lua
return {
  "plugin/name",
  cond = function()
    return vim.fn.executable("required-binary") == 1
  end,
}
```

#### Plugin with Custom Setup
```lua
return {
  "plugin/name",
  config = function()
    local plugin = require("plugin")
    plugin.setup({
      option1 = "value1",
      option2 = "value2",
    })
  end,
}
```

#### Keymap with Description
```lua
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {
  desc = "Find files"
})
```

### File Structure
```
.config/nvim/
├── init.lua              # Entry point
├── lua/
│   ├── base.lua          # Core Neovim options
│   ├── config/
│   │   ├── keymaps.lua   # Global keymaps
│   │   └── lazy.lua      # Plugin manager setup
│   └── plugins/          # Plugin configurations
│       ├── ai/
│       ├── completion/
│       ├── editing/
│       ├── git/
│       ├── language/
│       ├── navigation/
│       ├── ui/
│       └── workspace/
├── lazy-lock.json        # Plugin lockfile
├── AGENTS.md       # Agent documentation
└── .luarc.json           # Lua LSP configuration
```

### Environment Variables
- Respect user's existing Neovim configuration
- Don't assume specific paths or binaries exist
- Check for executables before configuring related plugins

### Best Practices
- Keep the configuration minimal and focused
- Prefer built-in Neovim features over plugins when possible
- Regularly update plugins and remove unused ones
- Document any custom scripts or workflows
- Test configuration on different systems when possible

### Troubleshooting
- Check `:checkhealth` for common issues
- Verify plugin dependencies are installed
- Test with minimal configuration to isolate problems
- Check Neovim version compatibility

Remember: This is a personal Neovim configuration, so changes should enhance the editing experience without breaking existing functionality.</content>
<parameter name="filePath">/Users/daominhtien/Dotfiles/AGENTS.md
