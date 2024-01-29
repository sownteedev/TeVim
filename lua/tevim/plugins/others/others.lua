local M = {}
M.blankline = {
	indentLine_enabled = 1,
	filetype_exclude = {
		"help",
		"terminal",
		"lazy",
		"lspinfo",
		"TelescopePrompt",
		"TelescopeResults",
		"mason",
		"tedash",
		"neo-tree",
		"",
	},
	buftype_exclude = { "terminal" },
	show_trailing_blankline_indent = false,
	show_first_indent_level = false,
	show_current_context = true,
	show_current_context_start = false,
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
	current_line_blame = true,
	current_line_blame_formatter = "     <author> (<author_time:%h %d, %Y>) • <summary>",
}

return M
