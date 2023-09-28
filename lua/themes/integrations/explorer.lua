local colors = require("themes").getCurrentTheme()

return {
	NeoTreeNormal = { fg = colors.white, bg = colors.darker_black },
	NeoTreeNormalNC = { fg = colors.white, bg = colors.darker_black },
	NeoTreeWinSeparator = { bg = colors.darker_black, fg = colors.darker_black },
	NeoTreeIndent = { fg = colors.grey },
	NeoTreeIndentMarker = { fg = colors.grey },
	NeoTreeDirectoryIcon = { fg = colors.folder_bg },
	NeoTreeRootName = { fg = colors.blue, bold = true },

	NeoTreeGitAdded = { fg = colors.green },
	NeoTreeGitConflict = { fg = colors.baby_pink },
	NeoTreeGitDeleted = { fg = colors.baby_pink },
	NeoTreeGitIgnored = { fg = colors.grey },
	NeoTreeGitModified = { fg = colors.orange },
	NeoTreeGitUnstaged = { fg = colors.baby_pink },
	NeoTreeGitUntracked = { fg = colors.blue },
	NeoTreeGitStaged = { fg = colors.green },
}
