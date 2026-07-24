local M = {}

local fallback_theme = "yoru"
local integrations_path = vim.fn.stdpath("config") .. "/lua/tevim/themes/integrations"

local function module_exists(module)
	local path = "lua/" .. module:gsub("%.", "/") .. ".lua"
	return #vim.api.nvim_get_runtime_file(path, false) > 0
end

local function load_palette(name)
	local custom_module = "custom.themes.schemes." .. name
	local core_module = "tevim.themes.schemes." .. name
	local module

	if module_exists(custom_module) then
		module = custom_module
	elseif module_exists(core_module) then
		module = core_module
	else
		return nil
	end

	-- Matugen and other generated themes may change while Neovim is running.
	package.loaded[module] = nil
	local colors = vim.deepcopy(require(module))
	local percentage = colors.type == "light" and -5 or 3
	local utils = require("tevim.core.utils")
	colors.lighter = utils.change_hex_lightness(colors.background, percentage)
	colors.darker = utils.change_hex_lightness(colors.background, -3)
	return colors
end

function M.getCurrentTheme()
	local name = vim.g.TeVimTheme or fallback_theme
	local colors = load_palette(name)

	if not colors then
		vim.notify_once(("TeVim theme %q was not found; using %q"):format(name, fallback_theme), vim.log.levels.WARN)
		name = fallback_theme
		vim.g.TeVimTheme = name
		colors = assert(load_palette(name), "TeVim fallback theme is missing")
	end

	return colors
end

function M.loadTb(name)
	return require("tevim.themes.integrations." .. name)
end

function M.loadCustomTb()
	if not module_exists("custom.themes.integrations") then
		return {}
	end
	return require("custom.themes.integrations")
end

local function integration_names()
	local names = {}
	for name, type in vim.fs.dir(integrations_path) do
		if type == "file" and name:sub(-4) == ".lua" then
			names[#names + 1] = name:sub(1, -5)
		end
	end
	table.sort(names)
	return names
end

local function collect_highlights()
	local highlights = {}

	for _, name in ipairs(integration_names()) do
		local module = "tevim.themes.integrations." .. name
		package.loaded[module] = nil
		highlights = vim.tbl_deep_extend("force", highlights, require(module))
	end

	package.loaded["custom.themes.integrations"] = nil
	highlights = vim.tbl_deep_extend("force", highlights, M.loadCustomTb())

	if vim.g.transparency then
		package.loaded["tevim.themes.transparency"] = nil
		for group, values in pairs(require("tevim.themes.transparency")) do
			if highlights[group] then
				highlights[group] = vim.tbl_deep_extend("force", highlights[group], values)
			end
		end
	end

	return highlights
end

function M.setTermColors(colors)
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

function M.load()
	local colors = M.getCurrentTheme()
	vim.o.background = colors.type == "light" and "light" or "dark"
	local highlights = collect_highlights()

	for group in pairs(vim._tevim_theme_highlight_groups or {}) do
		if not highlights[group] then
			vim.api.nvim_set_hl(0, group, {})
		end
	end
	local applied_groups = {}
	for group, values in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, values)
		applied_groups[group] = true
	end

	vim._tevim_theme_highlight_groups = applied_groups
	vim.g.colors_name = "tevim-" .. (vim.g.TeVimTheme or fallback_theme)
	M.setTermColors(colors)

	pcall(function()
		require("ibl").update()
	end)
end

return M
