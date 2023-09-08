vim.g.neo_tree_remove_legacy_commands = 1

vim.fn.sign_define("DiagnosticSignError",
	{ text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn",
	{ text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo",
	{ text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint",
	{ text = " ", texthl = "DiagnosticSignHint" })

require("neo-tree").setup({
	close_if_last_window = true,
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
	sort_case_insensitive = false,
	default_component_configs = {
		container = {
			enable_character_fade = true,
		},
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
				untracked = "",
				ignored = "",
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
			never_show = {
				".git",
			},
		},
		follow_current_file = {
			enabled = true,
		},
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
	event_handlers = {
		-- {
		--     event = "file_opened",
		--     handler = function()
		--         require("neo-tree.command").execute({ action = "close" })
		--     end,
		-- },
		{
			event = "neo_tree_window_after_open",
			handler = function(args)
				if args.position == "left" or args.position == "right" then
					vim.cmd("wincmd =")
				end
			end,
		},
		{
			event = "neo_tree_window_after_close",
			handler = function(args)
				if args.position == "left" or args.position == "right" then
					vim.cmd("wincmd =")
				end
			end,
		},
	},
})

