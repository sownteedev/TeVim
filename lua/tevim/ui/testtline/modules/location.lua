local M = function()
	return "%#TeSTTLocationIcon#"
		.. "  "
		.. "%#TeSTTLocation#"
		.. string.format(" %3d:%-2d ", vim.fn.line("."), vim.fn.virtcol("."))
end

return M
