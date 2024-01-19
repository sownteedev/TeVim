local configs = {
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

return configs
