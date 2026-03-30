-- Core keymaps that should exist before plugins are loaded.
local autosave = require("config.autosave")

local function spell_suggest()
	local bad_word = vim.fn.spellbadword(vim.fn.expand("<cword>"))[1]
	if bad_word == "" then
		vim.notify("No spelling suggestions for word under cursor", vim.log.levels.INFO, { title = "Neovim" })
		return
	end

	local suggestions = vim.fn.spellsuggest(bad_word, 8)
	if vim.tbl_isempty(suggestions) then
		vim.notify("No spelling suggestions available", vim.log.levels.INFO, { title = "Neovim" })
		return
	end

	vim.ui.select(suggestions, {
		prompt = ("Replace '%s' with:"):format(bad_word),
	}, function(choice)
		if not choice or choice == bad_word then
			return
		end
		vim.cmd.normal({ args = { "ciw" .. choice }, bang = true })
	end)
end

local function code_action_or_spell()
	local bad_word = vim.fn.spellbadword(vim.fn.expand("<cword>"))[1]
	if bad_word ~= "" then
		spell_suggest()
		return
	end

	vim.lsp.buf.code_action()
end

-- Save all
vim.keymap.set("n", "<leader><leader>", "<cmd>wa<cr>", { desc = "Save files" })

-- Diagnostics / LSP (built-in)
vim.keymap.set("n", "<leader>o", vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>c", code_action_or_spell, { desc = "Code action / spelling" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>s", "<cmd>LspRestart<cr>", { desc = "LSP restart" })
vim.keymap.set("n", "<leader>z", spell_suggest, { desc = "Spelling suggestions" })

-- Convenience
vim.keymap.set("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set({ "n", "v" }, "<C-y>", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("n", "<C-f>", "magg=<S-g>`a", { desc = "Format buffer" })
vim.keymap.set("n", "<leader>ta", autosave.toggle, { desc = "Toggle autosave" })
vim.keymap.set("n", "<leader>tf", function()
	vim.g.format_on_save_enabled = not vim.g.format_on_save_enabled
	vim.notify(
		"Format on save " .. (vim.g.format_on_save_enabled and "enabled" or "disabled"),
		vim.log.levels.INFO,
		{ title = "Neovim" }
	)
end, { desc = "Toggle format on save" })

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
