return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,

  config = function()
    require("oil").setup({
      default_file_explorer = true,

      -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
      skip_confirm_for_simple_edits = true,

      -- Oil will automatically delete hidden buffers after this delay
      -- You can set the delay to false to disable cleanup entirely
      -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
      cleanup_delay_ms = 1000,

      lsp_file_methods = {
        -- Time to wait for LSP file operations to complete before skipping
        timeout_ms = 100,
        -- Set to true to autosave buffers that are updated with LSP willRenameFiles
        -- Set to "unmodified" to only save unmodified buffers
        autosave_changes = true,
      },

      -- Set to true to watch the filesystem for changes and reload oil
      experimental_watch_for_changes = true,

      -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
      -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
      -- Additionally, if it is a string that matches "actions.<name>",
      -- it will use the mapping at require("oil.actions").<name>
      -- Set to `false` to remove a keymap
      -- See :help oil-actions for a list of all available actions
      keymaps = {
        ["g?"] = "actions.show_help",
        ["l"] = "actions.select",
        ["L"] = "actions.select_vsplit",
        ["J"] = "actions.select_split",
        ["K"] = "actions.preview",
        ["<C-q>"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["h"] = "actions.parent",
        [";;"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["H"] = "actions.toggle_hidden",
      },
    })
  end,
}
