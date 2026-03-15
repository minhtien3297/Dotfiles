return {
  'MeanderingProgrammer/render-markdown.nvim',
  lazy = 'VeryLazy',
  opts = {
    file_types = { "markdown", "md", "AgenticChat" },
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
