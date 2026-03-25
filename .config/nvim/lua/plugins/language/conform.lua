return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	init = function()
		vim.g.format_on_save_enabled = true
	end,
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			html = { "htmlbeautifier" },
			css = { "prettier" },
			bash = { "beautysh" },
			["*"] = { "codespell", "trim_whitespace", "trim_newlines" },
		},

		default_format_opts = {
			lsp_format = "fallback",
		},

		format_on_save = function(bufnr)
			if not vim.g.format_on_save_enabled then
				return nil
			end

			if vim.bo[bufnr].buftype ~= "" then
				return nil
			end

			return {
				lsp_format = "fallback",
				timeout_ms = 500,
			}
		end,
	},
}
