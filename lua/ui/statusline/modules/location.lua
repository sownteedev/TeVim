local M = function()
	if vim.o.columns < 130 then
		return ""
	end
	local line = vim.fn.line('.')
	local col = vim.fn.virtcol('.')
	return "%#TeSTTLocationIcon#" .. "    " .. "%#TeSTTLocation#" .. string.format(' %3d:%-2d ', line, col)
end

return M
