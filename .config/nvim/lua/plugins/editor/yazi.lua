return {
	"mikavilpas/yazi.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = "VeryLazy",
	config = function()
		require("yazi").setup({
			open_for_directories = true,
			floating_window_scaling_factor = 1,
			yazi_floating_window_border = "rounded",
		})
	end,
	init = function()
		vim.g.loaded_netrwPlugin = 1
	end,
}
