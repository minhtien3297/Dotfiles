return {
	"folke/trouble.nvim",
	cmd = "Trouble",

	keys = {
		{ ";u", function() require("trouble").toggle("lsp_references") end, desc = "References" },
		{ ";q", function() require("trouble").toggle("lsp_definitions") end, desc = "Definitions" },
		{ ";d", function() require("trouble").toggle("diagnostics") end, desc = "Diagnostics" },
		{ ";s", function() require("trouble").toggle("lsp_document_symbols") end, desc = "Symbols" },
	},

	opts = {
		auto_close = true,
		focus = true,

		modes = {
			symbols = {
				focus = true,
			},

			lsp_document_symbols = {
				win = { position = "right" },
			},
		},

		icons = {
			indent = {
				fold_open = "▼ ",
				fold_closed = "⏵ ",
			},
		},
	},
}
