local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local sorters = require("telescope.sorters")
local replaceword = require("tevim.core.utils").replaceword
local scheme = vim.fn.stdpath("config") .. "/lua/tevim/themes/schemes"
local custom_scheme = vim.fn.stdpath("config") .. "/lua/custom/themes/schemes"

local M = {}

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
	require("plenary.reload").reload_module("tevim.themes")
	require("tevim.themes").load()
	replaceword(
		"vim.g.TeVimTheme",
		'"' .. vim.g.TeVimTheme .. '"',
		'"' .. theme .. '"',
		vim.fn.stdpath("config") .. "/lua/custom/options.lua"
	)
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
	replaceword(
		"vim.g.transparency",
		tostring(not vim.g.transparency),
		tostring(vim.g.transparency),
		vim.fn.stdpath("config") .. "/lua/custom/options.lua"
	)
end

return M
