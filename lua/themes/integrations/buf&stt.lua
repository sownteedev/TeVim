local colors = require("themes").getCurrentTheme()

return {
	-- Buffer
	BufferLineFill = { fg = colors.grey, bg = colors.black },
	BufferLineBackground = { fg = colors.grey, bg = colors.black },

	BufferLineBuffer = { fg = colors.grey, bg = colors.black },
	BufferLineBufferSelected = { fg = colors.white, bg = colors.black, italic = true, bold = true },
	BufferLineBufferVisible = { fg = colors.grey, bg = colors.black },
	BufferLineBufferInactive = { fg = colors.grey, bg = colors.black },

	BufferLineModified = { fg = colors.green },
	BufferLineModifiedSelected = { fg = colors.green },
	BufferLineModifiedVisible = { fg = colors.green },
	BufferLineModifiedInactive = { fg = colors.green },

	BufferLineCloseButton = { fg = colors.grey },
	BufferLineCloseButtonSelected = { fg = colors.red },
	BufferLineCloseButtonVisible = { fg = colors.grey },
	BufferLineCloseButtonInactive = { fg = colors.grey },

	BufferLineTabClose = { fg = colors.grey, bg = colors.black },
	BufferLineTabCloseSelected = { fg = colors.red, bg = colors.black },
	BufferLineTabCloseVisible = { fg = colors.grey, bg = colors.black },
	BufferLineTabCloseInactive = { fg = colors.grey, bg = colors.black },

	BufferLineTab = { fg = colors.grey },
	BufferLineTabSelected = { fg = colors.grey },
	BufferLineTabVisible = { fg = colors.grey },
	BufferLineTabInactive = { fg = colors.grey },

	BufferLineSeparator = { fg = colors.black },
	BufferLineSeparatorSelected = { fg = colors.black },
	BufferLineSeparatorVisible = { fg = colors.black },
	BufferLineSeparatorInactive = { fg = colors.black },

	BufferLineIndicator = { fg = colors.grey },
	BufferLineIndicatorSelected = { fg = colors.cyan },
	BufferLineIndicatorVisible = { fg = colors.grey },
	BufferLineIndicatorInactive = { fg = colors.grey },

	BufferLinePick = { fg = colors.grey, bg = colors.black },
	BufferLinePickVisible = { fg = colors.grey, bg = colors.black },
	BufferLinePickSelected = { fg = colors.grey, bg = colors.black },
	BufferLinePickInactive = { fg = colors.grey, bg = colors.black },

	BufferLineClose = { fg = colors.grey, bg = colors.black },
	BufferLineCloseVisible = { fg = colors.grey, bg = colors.black },
	BufferLineCloseSelected = { fg = colors.red },
	BufferLineCloseInactive = { fg = colors.grey, bg = colors.black },

	BufferLineNumbers = { fg = colors.grey, bg = colors.black },
	BufferLineNumbersSelected = { bg = colors.black, italic = true, bold = true },
	BufferLineNumbersVisible = { fg = colors.grey, bg = colors.black },

	BufferLineDevIconLua = { fg = colors.grey, bg = colors.black },
	BufferLineDevIconLuaInactive = { fg = colors.grey, bg = colors.black },
	BufferLineDevIconLuaSelected = { fg = colors.blue, bg = colors.black },

	BufferLineTruncMarker = { fg = colors.grey, bg = colors.darker_black },

	-- Statusline
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

	Nothing = { fg = colors.black },
	NothingLighter = { fg = colors.black2 },

	TeSTTError = { fg = colors.red, bg = colors.black2 },
	TeSTTErrorIcon = { fg = colors.red, bg = colors.black2 },
	TeSTTWarning = { fg = colors.yellow, bg = colors.black2 },
	TeSTTWarningIcon = { fg = colors.yellow, bg = colors.black2 },
	TeSTTHints = { fg = colors.purple, bg = colors.black2 },
	TeSTTHintsIcon = { fg = colors.purple, bg = colors.black2 },
	TeSTTInfo = { fg = colors.blue, bg = colors.black2 },
	TeSTTInfoIcon = { fg = colors.blue, bg = colors.black2 },

	TeSTTBranchName = { fg = colors.purple, bg = colors.black2 },
	TeSTTBranchIcon = { fg = colors.black, bg = colors.purple },
	TeSTTDiffAdd = { fg = colors.green, bg = colors.black2 },
	TeSTTDiffChange = { fg = colors.orange, bg = colors.black2 },
	TeSTTDiffRemove = { fg = colors.red, bg = colors.black2 },
	TeSTTGithub = { fg = colors.black, bg = colors.blue },

	TeSTTTabIcon = { fg = colors.black, bg = colors.blue },
	TeSTTTab = { fg = colors.blue, bg = colors.black2 },

	TeSTTLsp = { fg = colors.green, bg = colors.black2 },
	TeSTTLspIcon = { fg = colors.black, bg = colors.green },
	TeSTTCopilot = { fg = colors.cyan, bg = colors.black2 },
	TeSTTCodeium = { fg = colors.cyan, bg = colors.black2 },

	TeSTTFolderText = { fg = colors.red, bg = colors.black2 },
	TeSTTFolderIcon = { fg = colors.black, bg = colors.red },

	TeSTTLocationIcon = { fg = colors.black, bg = colors.yellow },
	TeSTTLocation = { fg = colors.yellow, bg = colors.black2 },
}
