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
require("config.keymaps")
require("config.lazy")
