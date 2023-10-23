local M = function()
	local line = vim.fn.line('.')
	local col = vim.fn.virtcol('.')
	return "%#TeSTTLocationIcon#" .. "  " .. "%#TeSTTLocation#" .. string.format(' %3d:%-2d ', line, col)
end

return M
