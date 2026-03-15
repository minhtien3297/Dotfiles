return {
  "folke/todo-comments.nvim",
  event = "BufReadPost",
  cmd = { "TodoLocList", "TodoQuickFix", "TodoTelescope", "TodoTrouble" },
  keys = {
    { ";t", "<cmd>TodoTelescope<cr>", desc = "Todo" },
  },
  opts = {},
}
