return {
  'nvim-mini/mini.nvim',
  event = "VeryLazy",

  config = function()
    require('mini.icons').setup()
  end
}
