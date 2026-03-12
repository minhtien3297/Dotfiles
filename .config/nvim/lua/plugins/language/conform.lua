return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
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

    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 100,
    },
  },

  config = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.ts,*.tsx,*.jsx,*.js",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })
  end,
}
