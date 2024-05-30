return {
  "chrisgrieser/nvim-chainsaw",
  event = "VeryLazy",

  opts = {
    logStatements = {
      variableLog = {
        javascript = {
          "/* prettier-ignore */ // %s", -- adding this line
          'console.log("%s %s:", %s);',
        },
        typescript = {
          "/* prettier-ignore */ // %s", -- adding this line
          'console.log("%s %s:", %s);',
        },
      },
    },
  }
}
