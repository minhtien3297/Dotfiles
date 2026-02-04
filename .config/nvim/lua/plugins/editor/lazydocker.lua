return {
  "mgierada/lazydocker.nvim",
  dependencies = { "akinsho/toggleterm.nvim" },
  config = function()
    require("lazydocker").setup({
      border = "curved", -- valid options are "single" | "double" | "shadow" | "curved"
      width = 1,         -- width of the floating window (0-1 for percentage, >1 for absolute columns)
      height = 1,        -- height of the floating window (0-1 for percentage, >1 for absolute rows)
    })
  end,
  event = "BufRead",
}
