return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",

  config = function()
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local ts_conds = require("nvim-autopairs.ts-conds")

    npairs.setup({
      check_ts = true,
      enable_check_bracket_line = false,
      ignored_next_char = "[%w%.]",
    })

    -- press % => %% only while inside a comment or string
    npairs.add_rules({
      Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
      Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
    })
  end,
}
