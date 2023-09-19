local M = function()
	if vim.o.columns < 130 then
		return ""
	end
	return "%#TeSTTTabIcon#" .. "    " .. "%#TeSTTTab#" .. " " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
end

return M
