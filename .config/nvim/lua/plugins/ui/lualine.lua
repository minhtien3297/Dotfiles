return {
  "nvim-lualine/lualine.nvim",
  lazy = false,

  config = function()
    local status_package_info, package_info = pcall(require, "package-info")
    local status_trouble, trouble = pcall(require, "trouble")

    if status_package_info then
      vim.notify("package_info error")
    end

    if status_trouble then
      vim.notify("trouble error")
    end

    local symbols = trouble.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
    })

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "catppuccin",
        component_separators = " ",
        section_separators = "",
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
            symbols.get,
            cond = symbols.has,
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
              local msg = "null"
              local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
              local clients = vim.lsp.get_active_clients()

              if next(clients) == nil then
                return msg
              end

              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes

                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return client.name
                end
              end

              return msg
            end,

            icon = " LSP:",
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
