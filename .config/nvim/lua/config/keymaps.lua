-- Core keymaps that should exist before plugins are loaded.

-- Save all
vim.keymap.set("n", "<leader><leader>", "<cmd>wa<cr>", { desc = "Save files" })

-- Diagnostics / LSP (built-in)
vim.keymap.set("n", "<leader>o", vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>s", "<cmd>LspRestart<cr>", { desc = "LSP restart" })

-- Convenience
vim.keymap.set("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set({ "n", "v" }, "<C-y>", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("n", "<C-f>", "magg=<S-g>`a", { desc = "Format buffer" })

vim.keymap.set("n", "<C-g>", function()
	if vim.wo.relativenumber then
		vim.wo.relativenumber = false
		vim.wo.number = true
	else
		vim.wo.relativenumber = true
	end
end, { desc = "Toggle relative number" })

vim.keymap.set("n", "<S-l>", "<cmd>noh<cr>", { desc = "Clear search" })

-- Editing
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })

