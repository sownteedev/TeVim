local M = function()
	if vim.o.columns < 120 then
		return "%#Nothing2#" .. " "
	end
	return "%#Nothing#" .. "  "
end
return M
