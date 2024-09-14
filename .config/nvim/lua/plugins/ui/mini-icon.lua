return {
  'echasnovski/mini.icons',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  version = false,

  config = function()
    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()
  end
}
