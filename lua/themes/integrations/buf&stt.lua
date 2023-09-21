local colors = require("themes").getCurrentTheme()

return {
	-- Buffer
	BufferLineFill = { fg = colors.grey, bg = colors.statusline_bg },
	BufferLineBackground = { fg = colors.grey, bg = colors.statusline_bg },

	BufferLineBuffer = { fg = colors.grey, bg = colors.statusline_bg },
	BufferLineBufferSelected = { fg = colors.white, bg = colors.black, bold = true },
	BufferLineBufferInactive = { fg = colors.grey, bg = colors.statusline_bg },
	BufferLineBufferVisible = { fg = colors.grey, bg = colors.statusline_bg },

	BufferLineModified = { fg = colors.green },
	BufferLineModifiedSelected = { fg = colors.green },
	BufferLineModifiedVisible = { fg = colors.green },
	BufferLineModifiedInactive = { fg = colors.green },

	BufferLineCloseButton = { fg = colors.grey },
	BufferLineCloseButtonSelected = { fg = colors.red },
	BufferLineCloseButtonVisible = { fg = colors.grey },
	BufferLineCloseButtonInactive = { fg = colors.grey },

	BufferLineTabClose = { fg = colors.grey, bg = colors.statusline_bg },
	BufferLineTabCloseSelected = { fg = colors.red, bg = colors.black },
	BufferLineTabCloseVisible = { fg = colors.grey, bg = colors.statusline_bg },
	BufferLineTabCloseInactive = { fg = colors.grey, bg = colors.statusline_bg },

	BufferLineSeparator = { fg = colors.black },
	BufferLineSeparatorSelected = { fg = colors.black },
	BufferLineSeparatorVisible = { fg = colors.statusline_bg },
	BufferLineSeparatorInactive = { fg = colors.statusline_bg },

	BufferLineIndicator = { fg = colors.grey, bg = colors.statusline_bg },
	BufferLineIndicatorSelected = { fg = colors.cyan, bg = colors.black },
	BufferLineIndicatorVisible = { fg = colors.grey, bg = colors.statusline_bg },
	BufferLineIndicatorInactive = { fg = colors.grey, bg = colors.statusline_bg },

	BufferLinePick = { fg = colors.grey, bg = colors.statusline_bg },
	BufferLinePickVisible = { fg = colors.grey, bg = colors.statusline_bg },
	BufferLinePickSelected = { fg = colors.grey, bg = colors.black },
	BufferLinePickInactive = { fg = colors.grey, bg = colors.statusline_bg },

	BufferLineClose = { fg = colors.grey, bg = colors.statusline_bg },
	BufferLineCloseSelected = { fg = colors.red, bg = colors.black },
	BufferLineCloseInactive = { fg = colors.grey, bg = colors.statusline_bg },
	BufferLineCloseVisible = { fg = colors.grey, bg = colors.statusline_bg },

	BufferLineDevIconLua = { fg = colors.grey, bg = colors.statusline_bg },
	BufferLineDevIconLuaInactive = { fg = colors.grey, bg = colors.statusline_bg },
	BufferLineDevIconLuaSelected = { fg = colors.blue, bg = colors.black },

	BufferLineTruncMarker = { fg = colors.grey, bg = colors.statusline_bg },

	-- Statusline
	StatusLine = { fg = colors.statusline_bg, bg = colors.statusline_bg },
	TeSTTNormalMode = { fg = colors.blue, bg = colors.black2 },
	TeSTTVisualMode = { fg = colors.purple, bg = colors.black2 },
	TeSTTCommandMode = { fg = colors.red, bg = colors.black2 },
	TeSTTInsertMode = { fg = colors.green, bg = colors.black2 },
	TeSTTTerminalMode = { fg = colors.red, bg = colors.black2 },
	TeSTTNTerminalMode = { fg = colors.red, bg = colors.black2 },
	TeSTTConfirmMode = { fg = colors.yellow, bg = colors.black2 },

	TeSTTNormalModeIcon = { fg = colors.black, bg = colors.blue },
	TeSTTVisualModeIcon = { fg = colors.black, bg = colors.purple },
	TeSTTCommandModeIcon = { fg = colors.black, bg = colors.red },
	TeSTTInsertModeIcon = { fg = colors.black, bg = colors.green },
	TeSTTTerminalModeIcon = { fg = colors.black, bg = colors.red },
	TeSTTNTerminalModeIcon = { fg = colors.black, bg = colors.red },
	TeSTTConfirmModeIcon = { fg = colors.black, bg = colors.yellow },

	TeSTTFileIcon = { fg = colors.black, bg = colors.red },
	TeSTTFileName = { fg = colors.red, bg = colors.black2, bold = true },
	TeSTTFolder = { fg = colors.red, bg = colors.black2 },

	Nothing = { fg = colors.statusline_bg, bg = colors.statusline_bg },

	TeSTTError = { fg = colors.red, bg = colors.black2 },
	TeSTTErrorIcon = { fg = colors.red, bg = colors.black2 },
	TeSTTWarning = { fg = colors.yellow, bg = colors.black2 },
	TeSTTWarningIcon = { fg = colors.yellow, bg = colors.black2 },
	TeSTTHints = { fg = colors.purple, bg = colors.black2 },
	TeSTTHintsIcon = { fg = colors.purple, bg = colors.black2 },
	TeSTTInfo = { fg = colors.blue, bg = colors.black2 },
	TeSTTInfoIcon = { fg = colors.blue, bg = colors.black2 },

	TeSTTBranchName = { fg = colors.dark_purple, bg = colors.black2 },
	TeSTTBranchIcon = { fg = colors.black, bg = colors.dark_purple },
	TeSTTDiffAdd = { fg = colors.green, bg = colors.black2 },
	TeSTTDiffChange = { fg = colors.orange, bg = colors.black2 },
	TeSTTDiffRemove = { fg = colors.red, bg = colors.black2 },
	TeSTTGithub = { fg = colors.black, bg = colors.blue },

	TeSTTLsp = { fg = colors.green, bg = colors.black2 },
	TeSTTLspIcon = { fg = colors.black, bg = colors.green },
	TeSTTCopilot = { fg = colors.cyan, bg = colors.black2 },

	TeSTTTabIcon = { fg = colors.black, bg = colors.teal },
	TeSTTTab = { fg = colors.teal, bg = colors.black2 },

	TeSTTProgressIcon = { fg = colors.black, bg = colors.purple },
	TeSTTProgress = { fg = colors.purple, bg = colors.black2 },

	TeSTTLocationIcon = { fg = colors.black, bg = colors.yellow },
	TeSTTLocation = { fg = colors.yellow, bg = colors.black2 },
}
