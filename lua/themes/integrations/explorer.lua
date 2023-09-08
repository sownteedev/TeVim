return function(colors)
	return {
		NeoTreeNormal = { fg = colors.white, bg = colors.black },
		NeoTreeNormalNC = { fg = colors.white, bg = colors.black },
		NeoTreeWinSeparator = { bg = colors.black, fg = colors.black2 },
		NeoTreeIndent = { fg = colors.grey },
		NeoTreeIndentMarker = { fg = colors.grey },
		NeoTreeDirectoryIcon = { fg = colors.folder_bg },

		NeoTreeGitAdded = { fg = colors.green },
		NeoTreeGitConflict = { fg = colors.baby_pink },
		NeoTreeGitDeleted = { fg = colors.baby_pink },
		NeoTreeGitIgnored = { fg = colors.grey },
		NeoTreeGitModified = { fg = colors.orange },
		NeoTreeGitUnstaged = { fg = colors.baby_pink },
		NeoTreeGitUntracked = { fg = colors.blue },
		NeoTreeGitStaged = { fg = colors.green },
	}
end
