return {
  "vuki656/package-info.nvim",
  ft = "json",
  dependencies = { "MunifTanjim/nui.nvim" },

  config = function()
    require("package-info").setup({
      colors = {
        outdated = "#f38ba8", -- Text color for outdated dependency virtual text
      },

      icons = {
        enable = true,
        style = {
          outdated = " ▲ ",
        },
      },

      hide_up_to_date = true,
      hide_unstable_versions = true,
    })
  end
}
