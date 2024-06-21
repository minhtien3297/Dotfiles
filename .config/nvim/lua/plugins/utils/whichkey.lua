return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,

  config = function()
    local wk = require("which-key")
    local status_builtin, builtin = pcall(require, "telescope.builtin")
    local status_trouble, trouble = pcall(require, "trouble")
    local status_chainsaw, chainsaw = pcall(require, "chainsaw")
    local status_yazi, yazi = pcall(require, "yazi")

    if not status_builtin then
      vim.notify("telescope.builtin error")
      return
    end

    if not status_trouble then
      vim.notify("trouble error")
      return
    end

    if not status_chainsaw then
      vim.notify("chainsaw error")
      return
    end

    if not status_yazi then
      vim.notify("yazi error")
      return
    end

    wk.setup({
      ignore_missing = true,

      layout = { align = "center" }
    })

    wk.register({
      -- remap
      ["<leader><leader>"] = { "<cmd>:wa<CR>", "Save files" },
      ["<C-q>"] = { "<cmd>q<CR>", "Exit file" },
      ["<S-l>"] = { "<cmd>noh<CR>", "Clear search", noremap = true, silent = true },
      ["<C-f>"] = { "magg=<S-g>`a", "Format file", mode = "n" },

      ["<C-g>"] = {
        function()
          if vim.wo.relativenumber then
            -- If relative number is on, turn it off and enable absolute numbers
            vim.wo.relativenumber = false
            vim.wo.number = true
          else
            -- If relative number is off, turn it on
            vim.wo.relativenumber = true
          end
        end,
        "Toggle relative number"
      },

      ["<C-y>"] = { '"+y', "Copy to clipboard", mode = { "n", "v" } },

      J = {
        { "mzJ`z",            "Cut line easier",     mode = "n" },
        { ":m '>+1<CR>gv=gv", "Highlight rows down", mode = "v" },
      },

      K = {
        {
          function()
            vim.lsp.buf.hover()
          end,
          "Hover code",
        },
        {
          ":m '<-2<CR>gv=gv",
          "Highlight rows up",
          mode = "v",
        },
      },

      -- Markdown Preview
      ["<C-e>"] = { "<cmd>MarkdownPreviewToggle<CR>", "Toggle Markdown Preview" },

      ["<leader>"] = {
        -- lsp
        o = {
          function()
            vim.diagnostic.open_float()
          end,
          "Show diagnostic of word under",
        },

        c = {
          function()
            vim.lsp.buf.code_action()
          end,
          "Code action",
        },

        r = {
          function()
            vim.lsp.buf.rename()
          end,
          "Rename all references",
        },

        s = { "<cmd>LspRestart<CR>", "Lsp restart" },

        -- Obsidian
        m = { "<cmd>ObsidianOpen<CR>", "Open Obsidian" },
        n = { "<cmd>ObsidianNew<CR>", "New note" },
        t = { "<cmd>ObsidianBacklinks<CR>", "List Back Links" },
        i = { "<cmd>ObsidianPasteImg<CR>", "Paste Img" },

        -- lazygit
        f = { "<cmd>LazyGit<CR>", "LazyGit" },
      },

      [";"] = {
        -- yazi
        [";"] = {
          function()
            yazi.yazi()
          end,
          "Open Yazi"
        },

        -- yazi in cwd
        ["a"] = {
          function()
            yazi.yazi(nil, vim.fn.getcwd())
          end,
          "Open Yazi in cwd"
        },

        -- muren
        m = { "<cmd>MurenToggle<CR>", "Toggle Muren" },

        -- telescope
        f = {
          function()
            builtin.find_files()
          end,
          "Find File",
        },

        b = {
          function()
            builtin.buffers()
          end,
          "Find Buffers",
        },

        g = {
          function()
            builtin.live_grep()
          end,
          "Search String",
        },

        c = {
          function()
            builtin.commands()
          end,
          "Search Commands",
        },

        h = {
          function()
            builtin.help_tags()
          end,
          "Search Help",
        },

        t = {
          function()
            vim.cmd.TodoTelescope()
          end,
          "Search Todo",
        },

        n = {
          function()
            vim.cmd.Telescope("noice")
          end,
          "Search Notifications",
        },

        r = {
          function()
            builtin.registers()
          end,
          "Search registers",
        },

        k = {
          function()
            builtin.keymaps()
          end,
          "Search keymaps",
        },

        u = {
          function()
            trouble.toggle("lsp_references")
          end,
          "Go to references",
        },

        q = {
          function()
            trouble.toggle("lsp_definitions")
          end,
          "Go to definitions",
        },

        d = {
          function()
            trouble.toggle("diagnostics")
          end,
          "Diagnostics",
        },

        s = {
          function()
            trouble.toggle("lsp_document_symbols")
          end,
          "symbols",
        },

        -- chainsaw
        ['l'] = {
          name = "chainsaw",

          v = {
            function()
              chainsaw.variableLog()
            end,
            "log variable"
          },


          o = {
            function()
              chainsaw.objectLog()
            end,
            "log object"
          },

          a = {
            function()
              chainsaw.assertLog()
            end,
            "assert statement for variable"
          },

          m = {
            function()
              chainsaw.messageLog()
            end,
            "create a message"
          },

          s = {
            function()
              chainsaw.stacktraceLog()
            end,
            "log stacktrace"
          },

          b = {
            function()
              chainsaw.beepLog()
            end,
            "log minimal for flow inspection"
          },

          t = {
            function()
              chainsaw.timeLog()
            end,
            "log time: 1st call start, 2nd call end"
          },

          d = {
            function()
              chainsaw.debugLog()
            end,
            "debugger"
          },


          r = {
            function()
              chainsaw.removeLogs()
            end,
            "remove all logs"
          }
        }
      },
    })
  end,
}
