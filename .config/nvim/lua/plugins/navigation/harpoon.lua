return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  keys = {
    {
      "<leader>a",
      function()
        local harpoon = require("harpoon")
        harpoon:list():add()
        vim.notify("File added to Harpoon")
      end,
      desc = "Harpoon: add file",
    },
    {
      "<leader>e",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon: menu",
    },
  },

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
  end,
}
