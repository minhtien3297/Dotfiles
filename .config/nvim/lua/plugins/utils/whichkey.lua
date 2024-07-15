return {
  "folke/which-key.nvim",
  dependencies = { 'echasnovski/mini.icons', version = false },
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

    wk.add({
      { "<leader><leader>", "<cmd>:wa<CR>",                             desc = "Save files" },

      -- lsp
      { "<leader>o",        function() vim.diagnostic.open_float() end, desc = "Show diagnostic of word under", },
      { "<leader>c",        function() vim.lsp.buf.code_action() end,   desc = "Code action", },
      { "<leader>r",        function() vim.lsp.buf.rename() end,        desc = "Rename all references", },
      { "<leader>s",        "<cmd>LspRestart<CR>",                      desc = "Lsp restart" },

      -- Obsidian
      { "<leader>m",        "<cmd>ObsidianOpen<CR>",                    desc = "Open Obsidian" },
      { "<leader>n",        "<cmd>ObsidianNew<CR>",                     desc = "New note" },
      { "<leader>t",        "<cmd>ObsidianBacklinks<CR>",               desc = "List Back Links" },
      { "<leader>i",        "<cmd>ObsidianPasteImg<CR>",                desc = "Paste Img" },

      -- lazygit
      { "<leader>f",        "<cmd>LazyGit<CR>",                         desc = "LazyGit" },

      -- Markdown Preview
      { "<C-e>",            "<cmd>MarkdownPreviewToggle<CR>",           desc = "Toggle Markdown Preview" },

      -- remap
      { "<C-q>",            "<cmd>q<CR>",                               desc = "Exit file" },
      { "<C-y>",            '"+y',                                      desc = "Copy to clipboard",                                      mode = { "n", "v" } },
      { "<C-f>",            "magg=<S-g>`a",                             desc = "Format file",                                            mode = "n" },
      {
        "<C-g>",
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
        desc = "Toggle relative number"
      },
      { "<S-l>", "<cmd>noh<CR>",                                        desc = "Clear search",                                        noremap = true, silent = true },
      { "J",     "mzJ`z",                                               desc = "Cut line easier",                                     mode = "n" },
      { "J",     ":m '>+1<CR>gv=gv",                                    desc = "Highlight rows down",                                 mode = "v" },
      { "K",     function() vim.lsp.buf.hover() end,                    desc = "Hover code", },
      { "K",     ":m '<-2<CR>gv=gv",                                    desc = "Highlight rows up",                                   mode = "v", },

      -- yazi
      { ";;",    function() yazi.yazi() end,                            desc = "Open Yazi" },
      { ";a",    function() yazi.yazi(nil, vim.fn.getcwd()) end,        desc = "Open Yazi in cwd" },

      -- muren
      { ";m",    "<cmd>MurenToggle<CR>",                                desc = "Toggle Muren" },

      -- telescope
      { ";f",    function() builtin.find_files() end,                   desc = "Find File", },
      { ";b",    function() builtin.buffers() end,                      desc = "Find Buffers", },
      { ";g",    function() builtin.live_grep() end,                    desc = "Search String", },
      { ";c",    function() builtin.commands() end,                     desc = "Search Commands", },
      { ";h",    function() builtin.help_tags() end,                    desc = "Search Help", },
      { ";t",    function() vim.cmd.TodoTelescope() end,                desc = "Search Todo", },
      { ";n",    function() vim.cmd.Telescope("noice") end,             desc = "Search Notifications", },
      { ";r",    function() builtin.registers() end,                    desc = "Search registers", },
      { ";k",    function() builtin.keymaps() end,                      desc = "Search keymaps", },

      -- trouble
      { ";u",    function() trouble.toggle("lsp_references") end,       desc = "Go to references", },
      { ";q",    function() trouble.toggle("lsp_definitions") end,      desc = "Go to definitions", },
      { ";d",    function() trouble.toggle("diagnostics") end,          desc = "Diagnostics", },
      { ";s",    function() trouble.toggle("lsp_document_symbols") end, desc = "symbols", },

      -- chainsaw
      { ";l",    group = "chainsaw" },
      { ";lv",   function() chainsaw.variableLog() end,                 desc = "log variable" },
      { ";lo",   function() chainsaw.objectLog() end,                   desc = "log object" },
      { ";la",   function() chainsaw.assertLog() end,                   desc = "assert statement for variable" },
      { ";lm",   function() chainsaw.messageLog() end,                  desc = "create a message" },
      { ";ls",   function() chainsaw.stacktraceLog() end,               desc = "log stacktrace" },
      { ";lb",   function() chainsaw.beepLog() end,                     desc = "log minimal for flow inspection" },
      { ";lt",   function() chainsaw.timeLog() end,                     desc = "log time: 1st call start, 2nd call end" },
      { ";ld",   function() chainsaw.debugLog() end,                    desc = "debugger" },
      { ";lr",   function() chainsaw.removeLogs() end,                  desc = "remove all logs" }
    })
  end,
}
