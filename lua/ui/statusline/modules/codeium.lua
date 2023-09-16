local M = function()
	if vim.fn.exists(":Codeium") == 2 then
		return "%#TeSTTCodeium#" .. " 󰘦  "
	end
	return ""
end

return M
