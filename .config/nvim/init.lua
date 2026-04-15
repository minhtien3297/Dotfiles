if vim.loader then
	local cache_dir = vim.fn.stdpath("cache")
	if vim.fn.isdirectory(cache_dir) == 0 then
		pcall(vim.fn.mkdir, cache_dir, "p")
	end
	if vim.fn.filewritable(cache_dir) == 2 then
		pcall(vim.loader.enable)
	end
end

require("base")
require("config.autosave").setup()
require("config.keymaps")
require("config.lazy")

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local path = vim.api.nvim_buf_get_name(buf)
    if path ~= "" and vim.fn.filereadable(path) == 1 then
      local dir = vim.fn.fnamemodify(path, ":p:h")
      local f = io.open(os.getenv("HOME") .. "/.nvim_last_dir", "w")
      if f then
        f:write(dir)
        f:close()
      end
    end
  end,
})
