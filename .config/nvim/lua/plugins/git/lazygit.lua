return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  keys = {
    { "<leader>f", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
  config = function()
    vim.g.lazygit_floating_window_scaling_factor = 1
  end,
}
