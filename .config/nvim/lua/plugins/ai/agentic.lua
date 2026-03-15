return {
  "carlos-algms/agentic.nvim",
  keys = {
    { "<leader>//", function() require("agentic").toggle() end, desc = "Agentic: toggle chat", mode = "n" },
    { "<leader>/s", function() require("agentic").stop_generation() end, desc = "Agentic: stop generation" },
    { "<leader>/r", function() require("agentic").restore_session() end, desc = "Agentic: restore session" },
    { "<leader>/n", function() require("agentic").new_session() end, desc = "Agentic: new session" },
    { "<leader>/p", function() require("agentic").new_session_with_provider() end, desc = "Agentic: new session (provider)" },
    { "<leader>/x", function() require("agentic").add_selection_or_file_to_context() end, desc = "Agentic: add selection/file" },
  },

  opts = {
    provider = "codex-acp",

    diff_preview = {
      enabled = false,
    },

    hooks = {
      on_prompt_submit = function(data)
        vim.notify("Prompt submitted: " .. data.prompt:sub(1, 50))
      end,

      on_response_complete = function(data)
        if data.success then
          vim.notify("Agent finished!", vim.log.levels.INFO)
        else
          vim.notify("Agent error: " .. vim.inspect(data.error), vim.log.levels.ERROR)
        end
      end,
    },

    keymaps = {
      widget = {
        close = "q",
        switch_provider = "s",
        switch_model = "m",
      },

      prompt = {
        paste_image = {
          { "p", mode = { "n" } },
        },
      },
    },
  },
}
