local fn = vim.fn
local M = function()
	if vim.o.columns < 130 then
		return ""
	end
	local icon = "  "
	local directory = " " .. fn.fnamemodify(fn.getcwd(), ":t")
	local filename = (fn.expand "%" == "" and "Empty ") or fn.expand "%:t"
	if filename ~= "Empty " then
		local devicons = require("nvim-web-devicons")
		local ft_icon = devicons.get_icon(filename)
		icon = (ft_icon ~= nil and " " .. ft_icon) or ""
		if string.find(filename, "tree") then
			filename = "File Explorer"
			return "%#TeSTTFileIcon#" .. "  󰝰  " .. "%#TeSTTFileName#" .. " " .. filename .. " "
		end
		if string.find(filename, "toggleterm") then
			filename = "Terminal"
			return "%#TeSTTFileIcon#" .. "    " .. "%#TeSTTFileName#" .. " " .. filename .. " "
		end
		return "%#TeSTTFileIcon#" ..
			" " .. icon .. "  " .. "%#TeSTTFolder#" .. directory .. "/" .. "%#TeSTTFileName#" .. filename .. " "
	else
		return "%#TeSTTFileIcon#" .. " " .. icon .. " " .. "%#TeSTTFileName# TeVim "
	end
end
return M
