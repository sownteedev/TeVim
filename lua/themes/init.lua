local M           = {}
local hl_files    = vim.fn.stdpath "config" .. "/lua/themes/integrations"

M.getCurrentTheme = function()
	local path = "themes.schemes." .. vim.g.currentTheme
	local theme = require(path).get_colors()
	return theme
end

M.loadTb          = function(g)
	g = require("themes.integrations." .. g)
	return g
end

M.tableToStr      = function(tb)
	local result = ""
	for hlgroupName, hlgroup_vals in pairs(tb) do
		local hlname = "'" .. hlgroupName .. "',"
		local opts = ""
		for optName, optVal in pairs(hlgroup_vals) do
			local valueInStr = ((type(optVal)) == "boolean" or type(optVal) == "number") and tostring(optVal)
				or '"' .. optVal .. '"'
			opts = opts .. optName .. "=" .. valueInStr .. ","
		end
		result = result .. "vim.api.nvim_set_hl(0," .. hlname .. "{" .. opts .. "})"
	end
	return result
end

M.setTermColors   = function()
	local colors            = M.getCurrentTheme()
	vim.g.terminal_color_0  = colors.base01
	vim.g.terminal_color_1  = colors.base08
	vim.g.terminal_color_2  = colors.base0B
	vim.g.terminal_color_3  = colors.base0A
	vim.g.terminal_color_4  = colors.base0D
	vim.g.terminal_color_5  = colors.base0E
	vim.g.terminal_color_6  = colors.base0C
	vim.g.terminal_color_7  = colors.base05
	vim.g.terminal_color_8  = colors.base03
	vim.g.terminal_color_9  = colors.base08
	vim.g.terminal_color_10 = colors.base0B
	vim.g.terminal_color_11 = colors.base0A
	vim.g.terminal_color_12 = colors.base0D
	vim.g.terminal_color_13 = colors.base0E
	vim.g.terminal_color_14 = colors.base0C
	vim.g.terminal_color_15 = colors.base07
end

M.toCache         = function(filename, tb)
	local lines = "return string.dump(function()" .. M.tableToStr(tb) .. "end, true)"
	local file = io.open(vim.g.theme_cache .. filename, "wb")
	if file then
		---@diagnostic disable-next-line: deprecated
		file:write(loadstring(lines)())
		file:close()
	end
end

M.compile         = function()
	if not vim.loop.fs_stat(vim.g.theme_cache) then
		vim.fn.mkdir(vim.g.theme_cache, "p")
	end
	for _, file in ipairs(vim.fn.readdir(hl_files)) do
		local filename = vim.fn.fnamemodify(file, ":r")
		M.toCache(filename, M.loadTb(filename))
	end
end

M.load            = function()
	M.compile()
	for _, file in ipairs(vim.fn.readdir(vim.g.theme_cache)) do
		dofile(vim.g.theme_cache .. file)
	end
	M.setTermColors()
end

vim.api.nvim_create_user_command("TeVimThemes", function()
	vim.cmd("lua require('themes.switch').setup()")
end, {})

vim.api.nvim_create_user_command("TeVimThemesToggle", function()
	vim.cmd("lua require('themes.switch').toggleTheme()")
end, {})

return M
