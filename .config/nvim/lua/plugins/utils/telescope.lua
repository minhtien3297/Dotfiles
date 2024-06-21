return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  event = "VeryLazy",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    'nvim-telescope/telescope-ui-select.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    }
  },

  config = function()
    local telescope = require("telescope")
    local telescope_preview = require("telescope.previewers.utils")
    local telescope_themes = require("telescope.themes")

    telescope.setup({
      defaults = {
        preview = {
          mime_hook = function(filepath, bufnr, opts)
            local is_image = function(filepath)
              local image_extensions = { "png", "jpg", "gif", "jpeg" } -- Supported image formats
              local split_path = vim.split(filepath:lower(), ".", { plain = true })
              local extension = split_path[#split_path]

              return vim.tbl_contains(image_extensions, extension)
            end

            if is_image(filepath) then
              local term = vim.api.nvim_open_term(bufnr, {})

              local function send_output(_, data, _)
                for _, d in ipairs(data) do
                  vim.api.nvim_chan_send(term, d .. "\r\n")
                end
              end

              vim.fn.jobstart({
                "catimg",
                filepath, -- Terminal image viewer command
              }, { on_stdout = send_output, stdout_buffered = true, pty = true })
            else
              telescope_preview.set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
            end
          end,
        },

        layout_strategy = "vertical",
        layout_config = { height = 0.99, width = 0.99 },
      },

      pickers = {
        find_files = {
          hidden = true,
        },
      },

      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },

        ["ui-select"] = {
          telescope_themes.get_dropdown {}
        }
      },
    })

    telescope.load_extension("noice")
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
  end,
}
