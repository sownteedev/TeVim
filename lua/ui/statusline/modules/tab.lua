local M = function()
	return "%#TeSTTTabIcon#" .. "  " .. "%#TeSTTTab#" .. " " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
end

return M
