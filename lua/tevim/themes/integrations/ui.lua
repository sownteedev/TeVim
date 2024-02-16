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
	TeSTTNormalMode = { fg = colors.blue, bg = utils.blend(colors.blue, colors.black, 0.1) },
	TeSTTVisualMode = { fg = colors.purple, bg = utils.blend(colors.purple, colors.black, 0.1) },
	TeSTTCommandMode = { fg = colors.red, bg = utils.blend(colors.red, colors.black, 0.1) },
	TeSTTInsertMode = { fg = colors.green, bg = utils.blend(colors.green, colors.black, 0.1) },
	TeSTTTerminalMode = { fg = colors.red, bg = utils.blend(colors.red, colors.black, 0.1) },
	TeSTTNTerminalMode = { fg = colors.red, bg = utils.blend(colors.red, colors.black, 0.1) },
	TeSTTConfirmMode = { fg = colors.yellow, bg = utils.blend(colors.yellow, colors.black, 0.1) },
	TeSTTNormalModeIcon = { fg = colors.black, bg = colors.blue },
	TeSTTVisualModeIcon = { fg = colors.black, bg = colors.purple },
	TeSTTCommandModeIcon = { fg = colors.black, bg = colors.red },
	TeSTTInsertModeIcon = { fg = colors.black, bg = colors.green },
	TeSTTTerminalModeIcon = { fg = colors.black, bg = colors.red },
	TeSTTNTerminalModeIcon = { fg = colors.black, bg = colors.red },
	TeSTTConfirmModeIcon = { fg = colors.black, bg = colors.yellow },

	TeSTTFileIcon = { fg = colors.black, bg = colors.red },
	TeSTTFileName = { fg = colors.red, bg = utils.blend(colors.red, colors.black, 0.1), bold = true },
	TeSTTFolder = { fg = colors.red, bg = utils.blend(colors.red, colors.black, 0.1), italic = true },

	TeSTTNothing = { bg = colors.statusline_bg },
	TeSTTNothing2 = { bg = colors.black },

	TeSTTLsp = { fg = colors.green, bg = utils.blend(colors.green, colors.black, 0.1) },
	TeSTTLspIcon = { fg = colors.black, bg = colors.green },
	TeSTTCopilot = { fg = colors.cyan, bg = utils.blend(colors.green, colors.black, 0.1) },

	TeSTTError = { fg = colors.red, bg = utils.blend(colors.green, colors.black, 0.1) },
	TeSTTErrorIcon = { fg = colors.red, bg = utils.blend(colors.green, colors.black, 0.1) },
	TeSTTWarning = { fg = colors.yellow, bg = utils.blend(colors.green, colors.black, 0.1) },
	TeSTTWarningIcon = { fg = colors.yellow, bg = utils.blend(colors.green, colors.black, 0.1) },
	TeSTTHints = { fg = colors.purple, bg = utils.blend(colors.green, colors.black, 0.1) },
	TeSTTHintsIcon = { fg = colors.purple, bg = utils.blend(colors.green, colors.black, 0.1) },
	TeSTTInfo = { fg = colors.blue, bg = utils.blend(colors.green, colors.black, 0.1) },
	TeSTTInfoIcon = { fg = colors.blue, bg = utils.blend(colors.green, colors.black, 0.1) },

	TeSTTBranchName = { fg = colors.dark_purple, bg = utils.blend(colors.dark_purple, colors.black, 0.1) },
	TeSTTBranchIcon = { fg = colors.black, bg = colors.dark_purple },
	TeSTTDiffAdd = { fg = colors.green, bg = utils.blend(colors.blue, colors.black, 0.1) },
	TeSTTDiffChange = { fg = colors.orange, bg = utils.blend(colors.blue, colors.black, 0.1) },
	TeSTTDiffRemove = { fg = colors.red, bg = utils.blend(colors.blue, colors.black, 0.1) },
	TeSTTGithub = { fg = colors.black, bg = colors.blue },

	TeSTTTabIcon = { fg = colors.black, bg = colors.teal },
	TeSTTTab = { fg = colors.teal, bg = utils.blend(colors.teal, colors.black, 0.1) },

	TeSTTProgressIcon = { fg = colors.black, bg = colors.purple },
	TeSTTProgress = { fg = colors.purple, bg = utils.blend(colors.purple, colors.black, 0.1) },

	TeSTTLocationIcon = { fg = colors.black, bg = colors.yellow },
	TeSTTLocation = { fg = colors.yellow, bg = utils.blend(colors.yellow, colors.black, 0.1) },

	-- TeDash
	TeDashAscii = { fg = colors.black, bg = colors.blue },
	TeDashButtons = { fg = colors.white, bg = colors.black2 },
	TeDashBindKeys = { fg = colors.white, bg = colors.blue },
}
