return {
	"mason-org/mason-lspconfig.nvim",
  lazy = false,

	config = function()
		local servers = {
			"ts_ls",
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

		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_installation = true,
		})
	end,
}
