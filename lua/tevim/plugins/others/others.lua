local M = {}

M.blankline = {
	indent = {
		char = "│",
		tab_char = "│",
	},
	scope = { enabled = false },
	exclude = {
		filetypes = {
			"help",
			"alpha",
			"dashboard",
			"tedash",
			"neo-tree",
			"Trouble",
			"trouble",
			"lazy",
			"mason",
			"notify",
			"toggleterm",
			"lazyterm",
		},
	},
}

M.gitsigns = {
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "│" },
		topdelete = { text = "│" },
		changedelete = { text = "│" },
		untracked = { text = "┆" },
	},
	current_line_blame = false,
	current_line_blame_formatter = "     <author> (<author_time:%h %d, %Y>) • <summary>",
}

return M
