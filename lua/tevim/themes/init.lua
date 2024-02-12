local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local sorters = require("telescope.sorters")
local scheme = vim.fn.stdpath("config") .. "/lua/tevim/themes/schemes"
local hl_files = vim.fn.stdpath("config") .. "/lua/tevim/themes/integrations"
local custom_scheme = vim.fn.stdpath("config") .. "/lua/custom/themes/schemes"
local hl_files_custom = vim.fn.stdpath("config") .. "/lua/custom/themes/integrations"

local M = {}

M.getCurrentTheme = function()
	local default = "tevim.themes.schemes." .. vim.g.TeVimTheme
	local custom = "custom.themes.schemes." .. vim.g.TeVimTheme
	local check1, default_theme = pcall(require, default)
	local check2, custom_theme = pcall(require, custom)
	if check1 then
		return default_theme
	elseif check2 then
		return custom_theme
	end
end

M.loadTb = function(g)
	g = require("tevim.themes.integrations." .. g)
	return g
end

M.loadCustomTb = function(g)
	g = require("custom.themes.integrations")
	return g
end

M.merge_tb = function(...)
	return vim.tbl_deep_extend("force", ...)
end

M.setTrans = function(highlights)
	local glassy = require("tevim.themes.transparency")
	for key, value in pairs(glassy) do
		if highlights[key] then
			highlights[key] = M.merge_tb(highlights[key], value)
		end
	end
end

M.tableToStr = function(tb)
	local result = ""
	if vim.g.transparency then
		M.setTrans(tb)
	end
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

M.toCache = function(filename, tb)
	local lines = "return string.dump(function()" .. M.tableToStr(tb) .. "end, true)"
	local file = io.open(vim.g.theme_cache .. filename, "wb")
	if file then
		---@diagnostic disable-next-line: deprecated
		file:write(loadstring(lines)())
		file:close()
	end
end

local function indexOf(array, value)
	for i, v in ipairs(array) do
		if v == value then
			return i
		end
	end
	return nil
end
M.compile = function()
	if not vim.loop.fs_stat(vim.g.theme_cache) then
		vim.fn.mkdir(vim.g.theme_cache, "p")
	end
	local allThemes = {}
	for _, file in ipairs(vim.fn.readdir(hl_files)) do
		local filename = vim.fn.fnamemodify(file, ":r")
		local a = M.loadTb(filename)
		for k, f in pairs(a) do
			allThemes[k] = f
		end
	end
	local filename = vim.fn.fnamemodify(hl_files_custom, ":r")
	local a = M.loadCustomTb(filename)
	for k, f in pairs(a) do
		for _, i in pairs(allThemes) do
			if i == f then
				table.remove(allThemes, indexOf(allThemes, i))
				break
			end
		end
		allThemes[k] = f
	end
	M.toCache("allThemes", allThemes)
end

M.load = function()
	require("plenary.reload").reload_module("tevim.themes")
	M.compile()
	dofile(vim.g.theme_cache .. "allThemes")
end

M.setTermColors = function(colors)
	vim.g.terminal_color_0 = colors.base01
	vim.g.terminal_color_1 = colors.base08
	vim.g.terminal_color_2 = colors.base0B
	vim.g.terminal_color_3 = colors.base0A
	vim.g.terminal_color_4 = colors.base0D
	vim.g.terminal_color_5 = colors.base0E
	vim.g.terminal_color_6 = colors.base0C
	vim.g.terminal_color_7 = colors.base05
	vim.g.terminal_color_8 = colors.base03
	vim.g.terminal_color_9 = colors.base08
	vim.g.terminal_color_10 = colors.base0B
	vim.g.terminal_color_11 = colors.base0A
	vim.g.terminal_color_12 = colors.base0D
	vim.g.terminal_color_13 = colors.base0E
	vim.g.terminal_color_14 = colors.base0C
	vim.g.terminal_color_15 = colors.base07
end

---------------------------------------------------------------------
local function replaceword(middle, old, new)
	local file = vim.fn.stdpath("config") .. "/lua/custom/options.lua"
	local lines = vim.fn.readfile(file)
	local new_lines = {}
	local found = false
	for _, line in ipairs(lines) do
		if line:find(middle) then
			if line:find(old) then
				table.insert(new_lines, middle .. " = " .. new)
			else
				table.insert(new_lines, middle .. " = " .. old)
			end
			found = true
		else
			table.insert(new_lines, line)
		end
	end
	if not found then
		table.insert(new_lines, middle .. " = " .. new)
	end
	vim.fn.writefile(new_lines, file)
end

local themes = {}
for _, file in ipairs(vim.fn.readdir(scheme)) do
	table.insert(themes, vim.fn.fnamemodify(file, ":r"))
end
for _, file in ipairs(vim.fn.readdir(custom_scheme)) do
	table.insert(themes, vim.fn.fnamemodify(file, ":r"))
end

M.settheme = function(theme)
	vim.g.TeVimTheme = theme
	require("tevim.themes").setTermColors(theme)
	require("tevim.themes").load()
	replaceword("vim.g.TeVimTheme", '"' .. vim.g.TeVimTheme .. '"', '"' .. theme .. '"')
end

local picker_opts = {
	prompt_title = "TEVIM THEMES",
	finder = finders.new_table({ results = themes }),
	sorter = sorters.get_generic_fuzzy_sorter({}),
	attach_mappings = function(bufnr, map)
		map("i", "<CR>", function()
			M.settheme(action_state.get_selected_entry()[1])
			actions.close(bufnr)
		end)

		map("i", "<Down>", function()
			actions.move_selection_next(bufnr)
			M.settheme(action_state.get_selected_entry()[1])
		end)
		map("i", "<C-j>", function()
			actions.move_selection_next(bufnr)
			M.settheme(action_state.get_selected_entry()[1])
		end)

		map("i", "<Up>", function()
			actions.move_selection_previous(bufnr)
			M.settheme(action_state.get_selected_entry()[1])
		end)
		map("i", "<C-k>", function()
			actions.move_selection_previous(bufnr)
			M.settheme(action_state.get_selected_entry()[1])
		end)
		return true
	end,
}
M.setup = function()
	local picker = pickers.new({ layout_config = { height = 0.5, width = 0.25 } }, picker_opts)
	picker:find()
end

M.toggleTransparency = function()
	vim.g.transparency = not vim.g.transparency
	require("tevim.themes").load()
	replaceword("vim.g.transparency", tostring(not vim.g.transparency), tostring(vim.g.transparency))
end

return M
