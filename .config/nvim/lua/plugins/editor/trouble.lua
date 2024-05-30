return {
  "folke/trouble.nvim",
  branch = "dev",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  opts = {
    focus = true,

    modes = {
      symbols = {
        focus = true,
      },

      lsp_document_symbols = {
        win = { position = "right" }
      }
    },

    icons = {
      indent = {
        fold_open = "▼ ",
        fold_closed = "⏵ "
      },
    }
  }
}
