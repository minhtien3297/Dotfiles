return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
	lazy = false,
	config = function()
		require("render-markdown").setup({
			latex = {
				enabled = false,
			},
		})
	end,
}
