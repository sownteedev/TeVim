local colors = require("tevim.themes").getCurrentTheme()

return {
	NeoTreeNormal = { bg = colors.darker_black },
	NeoTreeNormalNC = { bg = colors.darker_black },
	NeoTreeWinSeparator = { bg = colors.black, fg = colors.black },
	NeoTreeIndentMarker = { fg = colors.one_bg },
	NeoTreeExpander = { fg = colors.grey },
	NeoTreeDirectoryIcon = { fg = colors.folder_bg },
	NeoTreeRootName = { fg = colors.blue, bold = true },
	NeoTreeModified = { fg = colors.green },

	NeoTreeGitAdded = { fg = colors.green },
	NeoTreeGitConflict = { fg = colors.baby_pink },
	NeoTreeGitDeleted = { fg = colors.baby_pink },
	NeoTreeGitIgnored = { fg = colors.grey },
	NeoTreeGitModified = { fg = colors.orange },
	NeoTreeGitUnstaged = { fg = colors.baby_pink },
	NeoTreeGitUntracked = { fg = colors.green },
	NeoTreeGitStaged = { fg = colors.green },
}
