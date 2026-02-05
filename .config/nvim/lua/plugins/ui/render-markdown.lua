return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
  lazy = 'VeryLazy',
  opts = {
    completions = {
      lsp = {
        enabled = true
      }
    },
    latex = {
      enabled = false
    }
  }
}
