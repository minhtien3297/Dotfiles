return {
  "carlos-algms/agentic.nvim",

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
