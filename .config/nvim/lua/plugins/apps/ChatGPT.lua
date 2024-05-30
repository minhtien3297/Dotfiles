return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("chatgpt").setup({
      api_key_cmd = "echo ",

      openai_params = {
        model = "gpt-4o",
      },

      openai_edit_params = {
        model = "gpt-4o",
        max_tokens = 3000,
      },

      use_openai_functions_for_edit = true,

      popup_layout = {
        default = "center",
        center = {
          width = "100%",
          height = "100%",
        },
        right = {
          width = "30%",
          width_settings_open = "50%",
        },
      },
    })
  end,
}
