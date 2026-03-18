return {
	"Exafunction/windsurf.nvim",
	event = "InsertEnter",
	config = function()
		require("codeium").setup({})
	end,
}
