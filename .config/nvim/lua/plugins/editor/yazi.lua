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
			log_level = vim.log.levels.ON,
		})
	end,
	init = function()
		vim.g.loaded_netrwPlugin = 1
	end,
}
