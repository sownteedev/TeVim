return {
	close_if_last_window = true,
	open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
	default_component_configs = {
		indent = {
			with_markers = false,
			indent_marker = "│",
			last_indent_marker = "└",
			with_expanders = true,
			expander_collapsed = "",
			expander_expanded = "",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
		},
		modified = { symbol = "●" },
		git_status = {
			symbols = {
				added = "",
				modified = "",
				deleted = "",
				renamed = "",
				untracked = "",
				ignored = "",
				unstaged = "",
				staged = "",
				conflict = "",
			},
		},
	},
	event_handlers = {
		{
			event = "neo_tree_window_after_open",
			handler = function(args)
				local function clear_winbar()
					if vim.go.winbar ~= "" then
						vim.go.winbar = ""
					end
					if vim.api.nvim_win_is_valid(args.winid) then
						vim.api.nvim_set_option_value("winbar", "", { scope = "local", win = args.winid })
						vim.api.nvim_set_option_value("number", false, { scope = "local", win = args.winid })
						vim.api.nvim_set_option_value("relativenumber", false, { scope = "local", win = args.winid })
						vim.api.nvim_set_option_value("statuscolumn", "", { scope = "local", win = args.winid })
					end
					for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].filetype == "tedash" then
							vim.o.showtabline = 0
							break
						end
					end
				end
				clear_winbar()
				vim.schedule(clear_winbar)
			end,
		},
	},
	window = { width = 30 },
	filesystem = {
		filtered_items = { hide_dotfiles = false, hide_gitignored = false },
		follow_current_file = { enabled = true },
		group_empty_dirs = true,
		use_libuv_file_watcher = true,
		components = {
			name = function(config, node, state)
				local cc = require("neo-tree.sources.common.components")
				local result = cc.name(config, node, state)
				if node:get_depth() == 1 then
					result.text = string.gsub(state.path, "(.*[/\\])(.*)", "%2")
				end
				return result
			end,
		},
	},
}
