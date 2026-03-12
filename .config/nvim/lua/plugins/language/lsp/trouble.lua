return {
	"folke/trouble.nvim",
	event = "VeryLazy",

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
