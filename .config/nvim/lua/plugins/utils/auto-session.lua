return {
  "rmagatti/auto-session",
  lazy = false,
  dependencies = "folke/noice.nvim",

  config = function()
    local as = require("auto-session")

    as.setup({
      enabled = true,
      log_level = "error",
      auto_session_enabled = true,
      auto_create = true,
      auto_save = true,
      auto_restore = true,
      use_git_branch = true,
      auto_restore_last_session = vim.loop.cwd() == vim.loop.os_homedir(),

      cwd_change_handling = {
        post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
          require("lualine").refresh()     -- refresh lualine so the new session name is displayed in the status bar
        end,
      }
    })

    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
  end,
}
