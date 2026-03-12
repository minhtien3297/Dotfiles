return {
  "nvim-telescope/telescope-ui-select.nvim",
  event = "VeryLazy",
  config = function()
    require("telescope").load_extension("ui-select")
  end,
}
