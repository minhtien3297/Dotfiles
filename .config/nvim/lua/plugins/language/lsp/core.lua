return {
	"neovim/nvim-lspconfig",
	cmd = { "LspInfo", "LspInstall", "LspStart" },
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"mfussenegger/nvim-lint",
	},

	config = function()
		local lint = require("lint")

		local servers = {
			"lua_ls",
			"bashls",
			"marksman",
			"hydra_lsp",
			"html",
			"cssls",
			"jsonls",
			"taplo",
			"tailwindcss",
			"typos_lsp",
		}

		vim.lsp.config("*", {})
		vim.lsp.enable(servers)

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
