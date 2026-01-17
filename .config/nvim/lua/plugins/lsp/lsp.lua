return {
  "neovim/nvim-lspconfig",
  cmd = { "LspInfo", "LspInstall", "LspStart" },
  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "lukas-reineke/lsp-format.nvim",
    "mfussenegger/nvim-lint",
  },

  config = function()
    local lint = require("lint")
    local lsp_format = require("lsp-format")

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

    lsp_format.setup({})

    vim.lsp.config("*", {})
    vim.lsp.enable(servers)

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        lsp_format.on_attach(client, args.buf)
      end,
    })
  end,
}
