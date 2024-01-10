local M = function()
	if vim.o.columns < 120 then
		return "%#TeSTTNothing2#" .. " "
	end
	return "%#TeSTTNothing#" .. "  "
end
return M
