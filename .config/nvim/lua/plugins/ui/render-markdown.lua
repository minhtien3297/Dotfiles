return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown", "md" },
	keys = {
		{ "<C-e>", function() require("render-markdown").preview() end, desc = "Markdown preview" },
	},
	opts = {
		file_types = { "markdown", "md" },
		completions = {
			lsp = {
				enabled = true,
			},
		},
		latex = {
			enabled = false,
		},
	},
}
