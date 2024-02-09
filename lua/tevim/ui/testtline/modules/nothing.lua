local M = function()
	if vim.o.columns < 120 or vim.bo.filetype == "tedash" then
		return "%#TeSTTNothing2#" .. " "
	end
	return "%#TeSTTNothing#" .. "   "
end
return M
