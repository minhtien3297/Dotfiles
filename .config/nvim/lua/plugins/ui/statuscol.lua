return {
  "luukvbaal/statuscol.nvim",
  lazy = false,

  config = function()
    local builtin = require("statuscol.builtin")

    require("statuscol").setup({
      relculright = true,
      thousands = ".",
      segments = {
        {
          sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },
          click = "v:lua.ScSa"
        },
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
        {
          sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
          click = "v:lua.ScSa"
        },
        {
          text = { " ", builtin.foldfunc, " " },
          condition = { builtin.not_empty, true, builtin.not_empty },
          click = "v:lua.ScFa",
        },
      },
    })
  end,
}
