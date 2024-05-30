return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",

  opts = {
    timeout = 1800,
    fps = 60,
    render = "wrapped-compact",
    stages = "fade",
    top_down = false,

    on_open = function(win)
      local buf = vim.api.nvim_win_get_buf(win)
      vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
    end,
  },
}
