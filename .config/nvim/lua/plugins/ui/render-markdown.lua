return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown", "md", "AgenticChat" },
	keys = {
		{ "<C-e>", function() require("render-markdown").preview() end, desc = "Markdown preview" },
	},
	opts = {
		file_types = { "markdown", "md", "AgenticChat" },
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
