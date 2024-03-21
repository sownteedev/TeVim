local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local replaceword = require("tevim.core.utils").replaceword

local M = {}

local themes = {}
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/tevim/themes/schemes")) do
	table.insert(themes, vim.fn.fnamemodify(file, ":r"))
end
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/custom/themes/schemes")) do
	table.insert(themes, vim.fn.fnamemodify(file, ":r"))
end
table.sort(themes)

M.setTheme = function(theme)
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

M.setup = function()
	pickers
		.new({
			prompt_title = " TEVIM COLORSCHEMES",
			layout_config = { height = 0.4, width = 0.2 },
			finder = finders.new_table({ results = themes }),
			sorter = conf.generic_sorter(),
			attach_mappings = function(bufnr, map)
				vim.schedule(function()
					vim.api.nvim_create_autocmd("TextChangedI", {
						buffer = bufnr,
						callback = function()
							if action_state.get_selected_entry() then
								M.setTheme(action_state.get_selected_entry()[1])
							end
						end,
					})
				end)
				map("i", "<CR>", function()
					M.setTheme(action_state.get_selected_entry()[1])
					actions.close(bufnr)
				end)

				map("i", "<Down>", function()
					actions.move_selection_next(bufnr)
					M.setTheme(action_state.get_selected_entry()[1])
				end)
				map("i", "<C-j>", function()
					actions.move_selection_next(bufnr)
					M.setTheme(action_state.get_selected_entry()[1])
				end)

				map("i", "<Up>", function()
					actions.move_selection_previous(bufnr)
					M.setTheme(action_state.get_selected_entry()[1])
				end)
				map("i", "<C-k>", function()
					actions.move_selection_previous(bufnr)
					M.setTheme(action_state.get_selected_entry()[1])
				end)
				return true
			end,
		})
		:find()
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
