return {
  "nvim-lualine/lualine.nvim",
  lazy = false,

  config = function()
    local status_package_info, package_info = pcall(require, "package-info")

    if status_package_info then
      vim.notify("package_info error")
    end

    require("lualine").setup({
      options = {
        theme = "catppuccin",
        component_separators = "",
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          "DashBoard"
        },
        globalstatus = true,
      },

      extensions = {
        'mason',
        'oil',
        'fzf',
        'lazy',
        'trouble',
        'quickfix',
      },

      sections = {
        lualine_b = { "branch", "diff" },

        lualine_c = {
          {
            "filename",
            path = 1,
          },

          {
            "diagnostics",

            symbols = {
              error = "✘ ",
              warn = "▲ ",
              hint = "⚑ ",
              info = "» ",
            },

            update_in_insert = true,
          },

          {
            function()
              return package_info.get_status()
            end,

            color = { fg = "#ffffff", gui = "bold" },
          }
        },

        lualine_x = {
          -- lsp
          {
            function()
              local clients = vim.lsp.get_clients()
              local c = {}

              if not clients then
                return ''
              end

              for _, client in pairs(clients) do
                table.insert(c, client.name)
              end

              return '\u{f085} ' .. table.concat(c, '|')
            end,

            color = { fg = "#ffffff", gui = "bold" },
          },

          "encoding",

          "filetype",

          -- lazy updates
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#ff9e64" },
          },
        },
      },
    })
  end,
}
