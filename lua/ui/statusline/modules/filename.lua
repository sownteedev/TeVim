local fn = vim.fn
local M = function()
	local icon = "  "
	local filename = (fn.expand "%" == "" and "Empty ") or fn.expand "%:t"
	if filename ~= "Empty " then
		local devicons = require("nvim-web-devicons")
		local ft_icon, icon_hl = devicons.get_icon(filename)
		icon = (ft_icon ~= nil and " " .. ft_icon) or ""
		if string.find(filename, "tree") then
			filename = "File Explorer"
			return "%#TeSTTFileIcon#" .. "    " .. "%#TeSTTFileName#" .. " " .. filename .. " "
		end
		if string.find(filename, "toggleterm") then
			filename = "Terminal"
			return "%#TeSTTFileIcon#" .. "    " .. "%#TeSTTFileName#" .. " " .. filename .. " "
		end
		return "%#TeSTTFileIcon#" .. " " .. icon .. "  " .. "%#TeSTTFileName#" .. " " .. filename .. " "
	else
		return "%#TeSTTFileIcon#" .. " " .. icon .. " " .. "%#TeSTTFileName# TeVim "
	end
end
return M
