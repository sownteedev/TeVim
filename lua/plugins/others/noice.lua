local installed, noice = pcall(require, "noice")

if installed then
	noice.setup({
		presets = {
			bottom_search = false,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = false,
		},
		health = { checker = false },
		smart_move = {
			enabled = true,
			excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
		},
		views = {
			mini = {
				position = {
					row = "90%",
					col = "100%",
				},
			},
			cmdline_popup = {
				position = {
					row = "30%",
					col = "50%",
				},
				size = {
					width = 60,
					height = "auto",
				},
			},
		},
		cmdline = {
			enabled = true,
			view = "cmdline_popup",
			format = {
				cmdline = { pattern = "^:", icon = " ", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
				lua = false,
				help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
				input = {},
			},
		},
		messages = {
			enabled = true,
			view = "notify",
			view_warn = "notify",
			view_error = "notify",
			view_history = "messages",
			view_search = "virtualtext",
		},
		popupmenu = {
			enabled = true,
			backend = "nui",
			kind_icons = {},
		},
		redirect = {
			view = "popup",
			filter = { event = "msg_show" },
		},
		notify = {
			enabled = true,
			view = "notify",
		},
		lsp = {
			progress = { enabled = false },
			signature = { enabled = false },
			hover = { enabled = false },
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			message = {
				enabled = true,
				view = "notify",
				opts = {},
			},
			documentation = {
				view = "hover",
				opts = {
					lang = "markdown",
					replace = true,
					render = "plain",
					format = { "{message}" },
					win_options = { concealcursor = "n", conceallevel = 3 },
				},
			},
		},
		markdown = {
			hover = {
				["|(%S-)|"] = vim.cmd.help,
				["%[.-%]%((%S-)%)"] = require("noice.util").open,
			},
			highlights = {
				["|%S-|"] = "@text.reference",
				["@%S+"] = "@parameter",
				["^%s*(Parameters:)"] = "@text.title",
				["^%s*(Return:)"] = "@text.title",
				["^%s*(See also:)"] = "@text.title",
				["{%S-}"] = "@parameter",
			},
		},
		commands = {
			history = {
				view = "split",
				opts = { enter = true, format = "details" },
				filter = {
					any = {
						{ event = "notify" },
						{ error = true },
						{ warning = true },
						{ event = "msg_show", kind = { "" } },
						{ event = "lsp",      kind = "message" },
					},
				},
			},
			last = {
				view = "popup",
				opts = { enter = true, format = "details" },
				filter = {
					any = {
						{ event = "notify" },
						{ error = true },
						{ warning = true },
						{ event = "msg_show", kind = { "" } },
						{ event = "lsp",      kind = "message" },
					},
				},
				filter_opts = { count = 1 },
			},
			errors = {
				view = "popup",
				opts = { enter = true, format = "details" },
				filter = { error = true },
				filter_opts = { reverse = true },
			},
		},
	})
end
