local configs = {
	close_if_last_window = true,
	open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	sort_case_insensitive = false,
	default_component_configs = {
		container = { enable_character_fade = true },
		indent = {
			indent_size = 2,
			padding = 1,
			with_markers = false,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndent",
			with_expanders = true,
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeIndent",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
		},
		modified = {
			symbol = "●",
			highlight = "NeoTreeModified",
		},
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
	commands = {},
	window = {
		position = "left",
		width = 35,
		mappings = {
			["o"] = "open",
			["<c-x>"] = "open_split",
			["<c-v>"] = "open_vsplit",
		},
	},
	filesystem = {
		filtered_items = {
			visible = false,
			hide_dotfiles = false,
			hide_gitignored = false,
			never_show = {},
		},
		follow_current_file = { enabled = true },
		group_empty_dirs = true,
		bind_to_cwd = false,
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
	source_selector = {
		winbar = false,
		sources = {
			{ source = "filesystem", display_name = "  Files " },
			{ source = "buffers", display_name = "  Bufs " },
			{ source = "git_status", display_name = "  Git " },
		},
	},
}

return configs
