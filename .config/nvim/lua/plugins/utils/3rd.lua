return {
  {
    "vhyrro/luarocks.nvim",
    event = "VeryLazy",
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    dependencies = { "luarocks.nvim" },
    config = function()
      require('image').setup({
        integrations = {
          markdown = {
            clear_in_insert_mode = true,
            resolve_image_path = function(document_path, image_path, fallback)
              -- document_path is the path to the file that contains the image
              -- image_path is the potentially relative path to the image. for
              -- markdown it's `![](this text)`

              -- you can call the fallback function to get the default behavior
              return fallback(document_path, image_path)
            end,
          },
          html = { enabled = true, },
          css = { enabled = true, },
        },

        editor_only_render_when_focused = true,
        tmux_show_only_in_active_window = true,
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif", "*.svg" },
      })
    end
  }
}
