local M = function()
	local icon = " 󰢚 "
	local filename = (vim.fn.expand("%") == "" and "Empty ") or vim.fn.expand("%:t")
	if filename ~= "Empty " then
		local devicons = require("nvim-web-devicons")
		local ft_icon = devicons.get_icon(filename)
		icon = (ft_icon ~= nil and " " .. ft_icon) or ""
		if string.find(filename, "filesystem") then
			filename = "File Explorer"
			return "%#TeSTTFileIcon#" .. " 󰝰 " .. "%#TeSTTFileName#" .. " " .. filename .. " "
		end
		if string.find(filename, "toggleterm") then
			filename = "Terminal"
			return "%#TeSTTFileIcon#" .. "  " .. "%#TeSTTFileName#" .. " " .. filename .. " "
		end
		return "%#TeSTTFileIcon#"
			.. icon
			.. " "
			.. "%#TeSTTFolder#"
			.. " "
			.. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
			.. "/"
			.. "%#TeSTTFileName#"
			.. filename
			.. " "
	else
		return "%#TeSTTFileIcon#" .. icon .. "%#TeSTTFileName# TEVIM "
	end
end
return M
