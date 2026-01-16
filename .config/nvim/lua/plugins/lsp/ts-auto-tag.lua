return {
	"windwp/nvim-ts-autotag",
	event = "BufReadPre",

	config = function()
		require("nvim-ts-autotag").setup({})
	end,
}
