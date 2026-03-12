return {
  "folke/todo-comments.nvim",
  event = "BufReadPost",
  cmd = { "TodoLocList", "TodoQuickFix", "TodoTelescope", "TodoTrouble" },
  opts = {},
}
