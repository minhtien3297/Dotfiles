return {
  "chrisgrieser/nvim-chainsaw",
  event = "VeryLazy",

  opts = {
    logStatements = {
      variableLog = {
        javascript = {
          "/* prettier-ignore */ // {{marker}}",
          'console.log("{{marker}} {{var}} - {{lnum}}:", {{var}});',
        },
      },
    },
  }
}
