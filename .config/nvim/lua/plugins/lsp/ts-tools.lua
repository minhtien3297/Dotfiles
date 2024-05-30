return {
  "pmizio/typescript-tools.nvim",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    complete_function_calls = true,
    expose_as_code_action = "all"
  },
}
