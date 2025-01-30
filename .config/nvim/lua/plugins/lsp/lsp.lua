return {
  "neovim/nvim-lspconfig",
  cmd = { "LspInfo", "LspInstall", "LspStart" },
  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "lukas-reineke/lsp-format.nvim",
    "williamboman/mason-lspconfig.nvim",
    "mfussenegger/nvim-lint",
  },

  config = function()
    local lsp_zero = require("lsp-zero")
    local lspconfig = require("lspconfig")
    local lint = require("lint")
    lsp_zero.extend_lspconfig()

    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })
      lsp_zero.highlight_symbol(client, bufnr)

      if client.supports_method("textDocument/formatting") then
        require("lsp-format").on_attach(client)
      end

      lsp_zero.set_sign_icons({
        error = " ✘",
        warn = " ▲",
        hint = " ⚑",
        info = " »",
      })
    end)

    local servers = {
      "ts_ls",
      "lua_ls",
      "bashls",
      "marksman",
      "hydra_lsp",
      "html",
      "cssls",
      "volar",
      "jsonls",
      "taplo",
      "tailwindcss",
      "typos_lsp",
    }

    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_installation = true,

      handlers = {
        lsp_zero.default_setup,

        lua_ls = function()
          local lua_opts = lsp_zero.nvim_lua_ls()
          lspconfig.lua_ls.setup(lua_opts)
        end,
      },
    })

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
