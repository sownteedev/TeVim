local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local configs = {
	defaults = {
		layout_config = {
			horizontal = {
				prompt_position = "bottom",
				preview_width = 0.6,
				results_width = 0.7,
			},
			vertical = { mirror = false },
			width = 0.9,
			height = 0.9,
			preview_cutoff = 120,
		},
		find_command = { "rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
		prompt_prefix = "   ",
		selection_caret = "    ",
		entry_prefix = "    ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		file_ignore_patterns = { ".git/" },
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		set_env = { ["COLORTERM"] = "truecolor" },
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default + actions.center,
				["<c-t>"] = trouble.open_with_trouble,
			},
		},
	},
}

return configs
