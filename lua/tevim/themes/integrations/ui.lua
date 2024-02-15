local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	-- Tebufline
	TeBufOnActive = { fg = colors.white, bg = colors.black, bold = true },
	TeBufOnInactive = { fg = colors.grey, bg = colors.statusline_bg },
	TeBufFolderOnActive = { fg = colors.white, bg = colors.black, italic = true },
	TeBufFolderOnInactive = { fg = colors.grey, bg = colors.statusline_bg, italic = true },
	TeBufOnModified = { fg = colors.green },
	TeBufOffModified = { fg = colors.grey, bg = colors.statusline_bg },
	TeBufOnClose = { fg = colors.red, bg = colors.black },
	TeBufOffClose = { fg = colors.grey, bg = colors.statusline_bg },
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
	TeSTTNormalMode = { fg = colors.blue, bg = utils.darken(colors.blue, colors.one_bg, 0.08) },
	TeSTTVisualMode = { fg = colors.purple, bg = utils.darken(colors.purple, colors.one_bg, 0.08) },
	TeSTTCommandMode = { fg = colors.red, bg = utils.darken(colors.red, colors.one_bg, 0.08) },
	TeSTTInsertMode = { fg = colors.green, bg = utils.darken(colors.green, colors.one_bg, 0.08) },
	TeSTTTerminalMode = { fg = colors.red, bg = utils.darken(colors.red, colors.one_bg, 0.08) },
	TeSTTNTerminalMode = { fg = colors.red, bg = utils.darken(colors.red, colors.one_bg, 0.08) },
	TeSTTConfirmMode = { fg = colors.yellow, bg = utils.darken(colors.yellow, colors.one_bg, 0.08) },
	TeSTTNormalModeIcon = { fg = colors.black, bg = colors.blue },
	TeSTTVisualModeIcon = { fg = colors.black, bg = colors.purple },
	TeSTTCommandModeIcon = { fg = colors.black, bg = colors.red },
	TeSTTInsertModeIcon = { fg = colors.black, bg = colors.green },
	TeSTTTerminalModeIcon = { fg = colors.black, bg = colors.red },
	TeSTTNTerminalModeIcon = { fg = colors.black, bg = colors.red },
	TeSTTConfirmModeIcon = { fg = colors.black, bg = colors.yellow },

	TeSTTFileIcon = { fg = colors.black, bg = colors.red },
	TeSTTFileName = { fg = colors.red, bg = utils.darken(colors.red, colors.one_bg, 0.08), bold = true },
	TeSTTFolder = { fg = colors.red, bg = utils.darken(colors.red, colors.one_bg, 0.08), italic = true },

	TeSTTNothing = { bg = colors.statusline_bg },
	TeSTTNothing2 = { bg = colors.black },

	TeSTTError = { fg = colors.red, bg = utils.darken(colors.red, colors.one_bg, 0.08) },
	TeSTTErrorIcon = { fg = colors.red, bg = utils.darken(colors.red, colors.one_bg, 0.08) },
	TeSTTWarning = { fg = colors.yellow, bg = utils.darken(colors.yellow, colors.one_bg, 0.08) },
	TeSTTWarningIcon = { fg = colors.yellow, bg = utils.darken(colors.yellow, colors.one_bg, 0.08) },
	TeSTTHints = { fg = colors.purple, bg = utils.darken(colors.purple, colors.one_bg, 0.08) },
	TeSTTHintsIcon = { fg = colors.purple, bg = utils.darken(colors.purple, colors.one_bg, 0.08) },
	TeSTTInfo = { fg = colors.blue, bg = utils.darken(colors.blue, colors.one_bg, 0.08) },
	TeSTTInfoIcon = { fg = colors.blue, bg = utils.darken(colors.blue, colors.one_bg, 0.08) },

	TeSTTBranchName = { fg = colors.dark_purple, bg = utils.darken(colors.dark_purple, colors.one_bg, 0.08) },
	TeSTTBranchIcon = { fg = colors.black, bg = colors.dark_purple },
	TeSTTDiffAdd = { fg = colors.green, bg = utils.darken(colors.blue, colors.one_bg, 0.08) },
	TeSTTDiffChange = { fg = colors.orange, bg = utils.darken(colors.blue, colors.one_bg, 0.08) },
	TeSTTDiffRemove = { fg = colors.red, bg = utils.darken(colors.blue, colors.one_bg, 0.08) },
	TeSTTGithub = { fg = colors.black, bg = colors.blue },

	TeSTTLsp = { fg = colors.green, bg = utils.darken(colors.green, colors.one_bg, 0.08) },
	TeSTTLspIcon = { fg = colors.black, bg = colors.green },
	TeSTTCopilot = { fg = colors.cyan, bg = utils.darken(colors.green, colors.one_bg, 0.08) },

	TeSTTTabIcon = { fg = colors.black, bg = colors.teal },
	TeSTTTab = { fg = colors.teal, bg = utils.darken(colors.teal, colors.one_bg, 0.08) },

	TeSTTProgressIcon = { fg = colors.black, bg = colors.purple },
	TeSTTProgress = { fg = colors.purple, bg = utils.darken(colors.purple, colors.one_bg, 0.08) },

	TeSTTLocationIcon = { fg = colors.black, bg = colors.yellow },
	TeSTTLocation = { fg = colors.yellow, bg = utils.darken(colors.yellow, colors.one_bg, 0.08) },

	-- TeDash
	TeDashAscii = { fg = colors.black, bg = colors.blue },
	TeDashButtons = { fg = colors.white, bg = colors.black2 },
	TeDashBindKeys = { fg = colors.white, bg = colors.blue },
}
