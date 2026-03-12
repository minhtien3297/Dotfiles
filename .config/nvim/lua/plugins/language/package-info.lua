return {
	"vuki656/package-info.nvim",
	ft = "json",

	config = function()
		require("package-info").setup({
			highlights = {
				outdated = { fg = "#f38ba8" }, -- Text color for outdated dependency virtual text
			},

			icons = {
				enable = true,
				style = {
					outdated = " ▲ ",
				},
			},

			hide_up_to_date = true,
			hide_unstable_versions = true,
		})
	end,
}
