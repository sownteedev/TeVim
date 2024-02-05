local colors = require("tevim.themes").getCurrentTheme()

return {
	-- Tebufline
	TeBufOnActive = { bg = colors.black, fg = colors.white, bold = true },
	TeBufOnInactive = { fg = colors.grey_fg2, bg = colors.statusline_bg },
	TeBufOnModified = { fg = colors.green },
	TeBufOffModified = { fg = colors.grey_fg2, bg = colors.statusline_bg },
	TeBufOnClose = { fg = colors.red, bg = colors.black },
	TeBufOffClose = { fg = colors.grey_fg2, bg = colors.statusline_bg },
	TeBufTree = { bg = colors.darker_black },
	TeBufEmpty = { bg = colors.black },
	TeBufEmptyColor = { bg = colors.statusline_bg },
	TeBufCloseButton = { bg = colors.red, fg = colors.black },

	TeBufRun = { bg = colors.one_bg2, fg = colors.yellow },
	TeBufSplit = { bg = colors.one_bg2, fg = colors.blue },
	TeBufTrans = { bg = colors.one_bg2, fg = colors.cyan },
	TeBufTheme = { bg = colors.one_bg2, fg = colors.green },
	TeBufQuit = { bg = colors.red, fg = colors.one_bg2 },

	-- TeSttLine
	TeSTTNormalMode = { fg = colors.blue, bg = colors.one_bg },
	TeSTTVisualMode = { fg = colors.purple, bg = colors.one_bg },
	TeSTTCommandMode = { fg = colors.red, bg = colors.one_bg },
	TeSTTInsertMode = { fg = colors.green, bg = colors.one_bg },
	TeSTTTerminalMode = { fg = colors.red, bg = colors.one_bg },
	TeSTTNTerminalMode = { fg = colors.red, bg = colors.one_bg },
	TeSTTConfirmMode = { fg = colors.yellow, bg = colors.one_bg },
	TeSTTNormalModeIcon = { fg = colors.black, bg = colors.blue },
	TeSTTVisualModeIcon = { fg = colors.black, bg = colors.purple },
	TeSTTCommandModeIcon = { fg = colors.black, bg = colors.red },
	TeSTTInsertModeIcon = { fg = colors.black, bg = colors.green },
	TeSTTTerminalModeIcon = { fg = colors.black, bg = colors.red },
	TeSTTNTerminalModeIcon = { fg = colors.black, bg = colors.red },
	TeSTTConfirmModeIcon = { fg = colors.black, bg = colors.yellow },

	TeSTTFileIcon = { fg = colors.black, bg = colors.red },
	TeSTTFileName = { fg = colors.red, bg = colors.one_bg, bold = true },
	TeSTTFolder = { fg = colors.red, bg = colors.one_bg },
	TeSTTModified = { fg = colors.green, bg = colors.one_bg },

	TeSTTNothing = { bg = colors.statusline_bg },
	TeSTTNothing2 = { bg = colors.black },
	TeSTTNothing3 = { bg = colors.black },

	TeSTTError = { fg = colors.red, bg = colors.one_bg },
	TeSTTErrorIcon = { fg = colors.red, bg = colors.one_bg },
	TeSTTWarning = { fg = colors.yellow, bg = colors.one_bg },
	TeSTTWarningIcon = { fg = colors.yellow, bg = colors.one_bg },
	TeSTTHints = { fg = colors.purple, bg = colors.one_bg },
	TeSTTHintsIcon = { fg = colors.purple, bg = colors.one_bg },
	TeSTTInfo = { fg = colors.blue, bg = colors.one_bg },
	TeSTTInfoIcon = { fg = colors.blue, bg = colors.one_bg },

	TeSTTBranchName = { fg = colors.dark_purple, bg = colors.one_bg },
	TeSTTBranchIcon = { fg = colors.black, bg = colors.dark_purple },
	TeSTTDiffAdd = { fg = colors.green, bg = colors.one_bg },
	TeSTTDiffChange = { fg = colors.orange, bg = colors.one_bg },
	TeSTTDiffRemove = { fg = colors.red, bg = colors.one_bg },
	TeSTTGithub = { fg = colors.black, bg = colors.blue },

	TeSTTLsp = { fg = colors.green, bg = colors.one_bg },
	TeSTTLspIcon = { fg = colors.black, bg = colors.green },
	TeSTTCopilot = { fg = colors.cyan, bg = colors.one_bg },

	TeSTTTabIcon = { fg = colors.black, bg = colors.teal },
	TeSTTTab = { fg = colors.teal, bg = colors.one_bg },

	TeSTTProgressIcon = { fg = colors.black, bg = colors.purple },
	TeSTTProgress = { fg = colors.purple, bg = colors.one_bg },

	TeSTTLocationIcon = { fg = colors.black, bg = colors.yellow },
	TeSTTLocation = { fg = colors.yellow, bg = colors.one_bg },

	-- TeDash
	TeDashAscii = { fg = colors.black, bg = colors.blue },
	TeDashButtons = { fg = colors.white, bg = colors.black2 },
	TeDashBindKeys = { fg = colors.white, bg = colors.blue },
}
