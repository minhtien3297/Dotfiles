return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,

	init = function()
		vim.cmd.colorscheme("catppuccin")
	end,

	opts = {
		flavour = "mocha", -- latte, frappe, macchiato, mocha
		show_end_of_buffer = true, -- show the '~' characters after the end of buffers
		auto_integrations = true,
	},
}
