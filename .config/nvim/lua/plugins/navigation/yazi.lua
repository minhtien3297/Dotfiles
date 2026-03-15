return {
	"mikavilpas/yazi.nvim",
	keys = {
		{ ";;", function() require("yazi").yazi() end, desc = "Yazi" },
		{ ";a", function() require("yazi").yazi(nil, vim.fn.getcwd()) end, desc = "Yazi (cwd)" },
	},
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
