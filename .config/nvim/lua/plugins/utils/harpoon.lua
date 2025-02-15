return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" }, -- file navigation

  config = function()
    local harpoon = require("harpoon")
    local harpoon_extensions = require("harpoon.extensions")

    harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })

    local toggle_menu = function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end

    local list_append = function()
      harpoon:list():add()
      vim.notify("File added to Harpoon")
    end

    harpoon:extend({
      UI_CREATE = function(cx)
        vim.keymap.set("n", "<S-l>", function()
          harpoon.ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr })

        vim.keymap.set("n", "l", function()
          harpoon.ui:select_menu_item()
        end, { buffer = cx.bufnr })
      end,
    })

    vim.keymap.set("n", "<leader>a", list_append)
    vim.keymap.set("n", "<leader>e", toggle_menu)
  end,
}
