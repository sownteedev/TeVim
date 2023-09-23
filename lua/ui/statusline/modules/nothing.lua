local M = function()
	if vim.o.columns < 130 then
		return "%#Nothing2#" .. " "
	end
	return "%#Nothing#" .. "  "
end
return M
