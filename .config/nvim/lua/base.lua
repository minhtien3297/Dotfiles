vim.opt.guicursor = ""

-- Replace leader default with space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- encoding to utf-8
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Display line number and relative line
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indentation default to 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- spell check
vim.opt.spell = true
vim.opt.spelllang = "en"

-- turn off mode show in command
vim.opt.showmode = false

-- Auto wrap line when it's too long
vim.opt.wrap = true

-- Search include all uppercase and lowercase
vim.o.ignorecase = true
vim.o.smartcase = true

-- Add color to line cursor is in
vim.opt.cursorline = true

-- Display theme color
vim.o.termguicolors = true

-- decrease speed run command
vim.opt.timeoutlen = 250
vim.opt.timeout = true
vim.opt.updatetime = 250

-- show column right hand
vim.opt.colorcolumn = "0"

-- enable hyperlink for markdown
vim.opt.conceallevel = 2

-- enable virtual line diagnostic
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false
})
