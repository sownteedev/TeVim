local M = function()
	if vim.o.columns < 120 then
		return "%#TeSTTNothing2#" .. " "
	elseif vim.bo.filetype == "tedash" then
		return "%#TeSTTNothing3#" .. "   "
	end
	return "%#TeSTTNothing#" .. "   "
end
return M
