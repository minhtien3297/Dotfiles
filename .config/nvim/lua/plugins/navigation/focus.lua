return {
  "nvim-focus/focus.nvim",
  cmd = {
    "FocusSplitCycle",
    "FocusSplitDown",
    "FocusSplitLeft",
    "FocusSplitNicely",
    "FocusSplitRight",
    "FocusSplitUp",
  },
  keys = {
    { "<leader>h", "<cmd>FocusSplitLeft<cr>", desc = "Create or move to split (h)" },
    { "<leader>j", "<cmd>FocusSplitDown<cr>", desc = "Create or move to split (j)" },
    { "<leader>k", "<cmd>FocusSplitUp<cr>", desc = "Create or move to split (k)" },
    { "<leader>l", "<cmd>FocusSplitRight<cr>", desc = "Create or move to split (l)" },
  },

  opts = {
    ui = {
      number = false,
      relativenumber = false,
      hybridnumber = true,
    },
  },
}
