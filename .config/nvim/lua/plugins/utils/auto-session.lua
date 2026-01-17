return {
  "rmagatti/auto-session",
  lazy = false,

  config = function()
    local as = require("auto-session")

    as.setup({
      git_use_branch_name = true,
      git_auto_restore_on_branch_change = true,
      show_auto_restore_notif = true,
      cwd_change_handling = true,
      auto_restore_last_session = vim.loop.cwd() == vim.loop.os_homedir(),
    })

    local timer = vim.loop.new_timer()
    timer:start(0, 300000, vim.schedule_wrap(
      function()
        as.AutoSaveSession()
      end
    ))

    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
  end,
}
