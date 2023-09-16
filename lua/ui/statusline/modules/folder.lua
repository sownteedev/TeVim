local fn = vim.fn
local M = function()
	local directory = "%#TeSTTFolderText#" .. " " .. fn.fnamemodify(fn.getcwd(), ":t") .. " "
	local icon = "%#TeSTTFolderIcon#" .. "    "
	return icon .. directory
end

return M
