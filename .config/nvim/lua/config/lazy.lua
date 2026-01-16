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
	{ import = "plugins.ui" },
	{ import = "plugins.editor" },
	{ import = "plugins.lsp" },
	{ import = "plugins.utils" },
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
