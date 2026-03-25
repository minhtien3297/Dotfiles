local M = {}

local group = vim.api.nvim_create_augroup("config_autosave", { clear = true })

local state = {
	enabled = true,
}

local function notify(message)
	vim.notify(message, vim.log.levels.INFO, { title = "Neovim" })
end

local function can_autosave(bufnr)
	if not state.enabled then
		return false
	end

	if not vim.api.nvim_buf_is_valid(bufnr) then
		return false
	end

	if vim.bo[bufnr].buftype ~= "" or not vim.bo[bufnr].modifiable then
		return false
	end

	if not vim.bo[bufnr].modified then
		return false
	end

	return vim.api.nvim_buf_get_name(bufnr) ~= ""
end

local function save_buffer(bufnr)
	if not can_autosave(bufnr) then
		return
	end

	vim.api.nvim_buf_call(bufnr, function()
		pcall(vim.cmd, "silent update")
	end)
end

function M.setup()
	vim.api.nvim_create_autocmd("FocusLost", {
		group = group,
		callback = function()
			vim.schedule(function()
				local mode = vim.api.nvim_get_mode().mode
				if mode:match("^[iR]") then
					vim.cmd("stopinsert")
				end

				save_buffer(vim.api.nvim_get_current_buf())
			end)
		end,
	})

	vim.api.nvim_create_user_command("ToggleAutoSave", function()
		M.toggle()
	end, { desc = "Toggle autosave" })
end

function M.toggle()
	state.enabled = not state.enabled
	notify("Autosave " .. (state.enabled and "enabled" or "disabled"))
	return state.enabled
end

function M.is_enabled()
	return state.enabled
end

return M
