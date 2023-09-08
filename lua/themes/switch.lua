local pickers      = require "telescope.pickers"
local finders      = require "telescope.finders"
local actions      = require "telescope.actions"
local action_state = require "telescope.actions.state"
local conf         = require("telescope.config").values

local M            = {}
local files        = vim.fn.stdpath "config" .. "/colors/"
local themes       = {}

for _, file in ipairs(vim.fn.readdir(files)) do
	local f = vim.fn.fnamemodify(file, ":r")
	table.insert(themes, f)
end

-- Select themes with Telescope
M.setup = function(opts)
	opts = opts or {}
	pickers.new(opts, {
		prompt_title = " Select Themes",
		finder = finders.new_table {
			results = themes
		},
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(buffer)
			actions.select_default:replace(function()
				local theme = action_state.get_selected_entry().value
				vim.g.currentTheme = theme
				vim.cmd("colorscheme " .. theme)
				actions.close(buffer)
			end)
			return true
		end,
	}):find()
end

-- Click to toggle
M.toggleTheme = function()
	local theme = themes[math.random(#themes)]
	vim.cmd("colorscheme " .. theme)
end

return M
