return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  cmd = "Telescope",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-frecency.nvim",
  },

  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local sorters = require("telescope.sorters")
    local telescope_preview = require("telescope.previewers.utils")
    local telescope_themes = require("telescope.themes")
    local actions = require("telescope.actions")
    local telescope_config = require("telescope.config")

    local function buffer_search_root()
      local buffer_name = vim.api.nvim_buf_get_name(0)
      local start_path = buffer_name ~= "" and vim.fs.dirname(buffer_name) or vim.uv.cwd()
      local root_markers = { ".git", "package.json", "pyproject.toml", "Cargo.toml", "go.mod", ".hg" }
      local project_root = vim.fs.root(start_path, root_markers)

      return project_root or start_path
    end

    local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")
    table.insert(vimgrep_arguments, "--hidden")
    table.insert(vimgrep_arguments, "--follow")
    table.insert(vimgrep_arguments, "--smart-case")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close
          },
        },

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
        vimgrep_arguments = vimgrep_arguments,
      },

      pickers = {
        find_files = {
          hidden = true,
          follow = true,
          find_command = { "rg", "--files", "--hidden", "--follow", "--glob", "!**/.git/*" },
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

    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")
    pcall(telescope.load_extension, "frecency")
    pcall(telescope.load_extension, "noice")

    vim.keymap.set("n", ";f", function()
      builtin.find_files({
        cwd = buffer_search_root(),
        sorter = sorters.get_substr_matcher(),
      })
    end, { desc = "Find files" })

    vim.keymap.set("n", ";g", function()
      builtin.live_grep({
        cwd = buffer_search_root(),
        additional_args = function()
          return { "--hidden", "--follow", "--smart-case" }
        end,
      })
    end, { desc = "Live grep" })
  end,

  keys = {
    { ";f", desc = "Find files" },
    { ";b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { ";g", desc = "Live grep" },
    { ";c", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { ";h", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { ";r", "<cmd>Telescope registers<cr>", desc = "Registers" },
    { ";k", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { ";n", "<cmd>Telescope noice<cr>", desc = "Notifications" },
  },
}
