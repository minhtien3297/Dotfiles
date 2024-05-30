return {
  "laytan/tailwind-sorter.nvim",
  event = "VeryLazy",
  enabled = false,
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
  build = "cd formatter && npm ci && npm run build",
  config = function()
    require("tailwind-sorter").setup({
      on_save_enabled = true,
    })
  end,
}
