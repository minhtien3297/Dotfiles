return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",

  config = function()
    local parser_install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "treesitter", "parsers")
    vim.fn.mkdir(parser_install_dir, "p")
    vim.opt.runtimepath:append(parser_install_dir)

    require("nvim-treesitter.configs").setup({
      parser_install_dir = parser_install_dir,
      ensure_installed = "all",
      ignore_install = { "ipkg" },
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end,
}
