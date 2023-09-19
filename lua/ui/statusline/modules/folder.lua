local fn = vim.fn
local M = function()
	if vim.o.columns < 130 then
		return ""
	end
	local directory = "%#TeSTTFolderText#" .. " " .. fn.fnamemodify(fn.getcwd(), ":t") .. " "
	local icon = "%#TeSTTFolderIcon#" .. "    "
	return (vim.o.columns > 85 and (icon .. directory)) or ""
end

return M
