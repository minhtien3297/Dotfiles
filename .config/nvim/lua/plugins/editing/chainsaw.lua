return {
  "chrisgrieser/nvim-chainsaw",
  keys = {
    { ";lv", function() require("chainsaw").variableLog() end, desc = "Chainsaw: variable log" },
    { ";lo", function() require("chainsaw").objectLog() end, desc = "Chainsaw: object log" },
    { ";la", function() require("chainsaw").assertLog() end, desc = "Chainsaw: assert log" },
    { ";lm", function() require("chainsaw").messageLog() end, desc = "Chainsaw: message log" },
    { ";ls", function() require("chainsaw").stacktraceLog() end, desc = "Chainsaw: stacktrace log" },
    { ";lb", function() require("chainsaw").beepLog() end, desc = "Chainsaw: beep log" },
    { ";lt", function() require("chainsaw").timeLog() end, desc = "Chainsaw: time log" },
    { ";ld", function() require("chainsaw").debugLog() end, desc = "Chainsaw: debug log" },
    { ";lr", function() require("chainsaw").removeLogs() end, desc = "Chainsaw: remove logs" },
  },

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
