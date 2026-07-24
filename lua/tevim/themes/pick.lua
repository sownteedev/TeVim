local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local replaceword = require("tevim.core.utils").replaceword

local M = {}

local function add_themes(themes, seen, path)
	if not vim.uv.fs_stat(path) then
		return
	end
	for name, type in vim.fs.dir(path) do
		if type == "file" and name:sub(-4) == ".lua" then
			local theme = name:sub(1, -5)
			if not seen[theme] then
				seen[theme] = true
				themes[#themes + 1] = theme
			end
		end
	end
end

local function available_themes()
	local themes, seen = {}, {}
	local config = vim.fn.stdpath("config")

	-- Custom themes come first and override bundled themes with the same name.
	add_themes(themes, seen, config .. "/lua/custom/themes/schemes")
	add_themes(themes, seen, config .. "/lua/tevim/themes/schemes")
	table.sort(themes)
	return themes
end

local function persist_theme(theme)
	if theme == "matugen" then
		return
	end

	vim.g.TeVimThemeSource = theme
	replaceword(
		"vim.g.TeVimThemeSource",
		'"' .. theme .. '"',
		'"' .. theme .. '"',
		vim.fn.stdpath("config") .. "/lua/custom/options.lua"
	)
end

function M.setTheme(theme, persist)
	if not theme then
		return
	end
	vim.g.TeVimTheme = theme
	require("tevim.themes").load()
	if persist then
		persist_theme(theme)
	end
end

function M.setup()
	local original_theme = vim.g.TeVimTheme
	local confirmed = false

	pickers
		.new({
			prompt_title = " TEVIM COLORSCHEMES",
			layout_config = { height = 0.4, width = 0.2 },
			finder = finders.new_table({ results = available_themes() }),
			sorter = conf.generic_sorter(),
			attach_mappings = function(bufnr, map)
				local function preview()
					local selected = action_state.get_selected_entry()
					if selected then
						M.setTheme(selected[1], false)
					end
				end

				vim.api.nvim_create_autocmd("TextChangedI", {
					buffer = bufnr,
					callback = preview,
				})
				vim.api.nvim_create_autocmd("BufWipeout", {
					buffer = bufnr,
					once = true,
					callback = function()
						if not confirmed and original_theme then
							M.setTheme(original_theme, false)
						end
					end,
				})

				map("i", "<CR>", function()
					local selected = action_state.get_selected_entry()
					if selected then
						confirmed = true
						M.setTheme(selected[1], true)
					end
					actions.close(bufnr)
				end)
				map("i", "<Down>", function()
					actions.move_selection_next(bufnr)
					preview()
				end)
				map("i", "<C-j>", function()
					actions.move_selection_next(bufnr)
					preview()
				end)
				map("i", "<Up>", function()
					actions.move_selection_previous(bufnr)
					preview()
				end)
				map("i", "<C-k>", function()
					actions.move_selection_previous(bufnr)
					preview()
				end)
				return true
			end,
		})
		:find()
end

function M.toggleTransparency()
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
