-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
local plugins = {
	{ import = "plugins.ai" },
	{ import = "plugins.completion.cmp" },
	{ import = "plugins.completion.snippets" },
	{ import = "plugins.editing" },
	{ import = "plugins.git" },
	{ import = "plugins.language" },
	{ import = "plugins.language.lsp" },
	{ import = "plugins.language.treesitter" },
	{ import = "plugins.language.typescript" },
	{ import = "plugins.navigation" },
	{ import = "plugins.navigation.telescope" },
	{ import = "plugins.ui" },
	{ import = "plugins.ui.noice" },
	{ import = "plugins.ui.ufo" },
	{ import = "plugins.workspace" },
	{ import = "plugins.workspace.docker" },
}

local opts = {
	install = {
		colorscheme = { "catppuccin" },
	},

	defaults = {
		lazy = true,
		version = "*",
	},

	checker = {
		enabled = true,
	},

	ui = {
		size = { width = 1, height = 1 },
	},
}

require("lazy").setup(plugins, opts)
