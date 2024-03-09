local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	-- Tebufline
	TeBufOnActive = { fg = colors.foreground, bg = colors.background, bold = true },
	TeBufOnInactive = {
		fg = utils.blend(colors.foreground, colors.background, 0.2),
		bg = utils.blend(colors.foreground, colors.background, 0.02),
	},
	TeBufFolderOnActive = { fg = colors.foreground, bg = colors.background, italic = true },
	TeBufFolderOnInactive = {
		fg = utils.blend(colors.foreground, colors.background, 0.2),
		bg = utils.blend(colors.foreground, colors.background, 0.02),
		italic = true,
	},
	TeBufOnModified = { fg = colors.green },
	TeBufOffModified = {
		fg = utils.blend(colors.foreground, colors.background, 0.2),
		bg = utils.blend(colors.foreground, colors.background, 0.02),
	},
	TeBufOnClose = { fg = colors.red, bg = colors.background },
	TeBufOffClose = {
		fg = utils.blend(colors.foreground, colors.background, 0.2),
		bg = utils.blend(colors.foreground, colors.background, 0.02),
	},
	TeBufTree = { bg = colors.darker },
	TeBufEmpty = { bg = colors.background },
	TeBufEmptyColor = { bg = utils.blend(colors.foreground, colors.background, 0.01) },
	TeBufCloseButton = { bg = colors.red, fg = colors.background },

	TeBufRun = {
		bg = utils.blend(colors.foreground, colors.background, 0.08),
		fg = utils.mix(colors.red, colors.green, 0.5),
	},
	TeBufSplit = { bg = utils.blend(colors.foreground, colors.background, 0.08), fg = colors.blue },
	TeBufTrans = {
		bg = utils.blend(colors.foreground, colors.background, 0.08),
		fg = utils.mix(colors.foreground, colors.blue, 0.7),
	},
	TeBufTheme = { bg = utils.blend(colors.foreground, colors.background, 0.08), fg = colors.green },
	TeBufQuit = { bg = colors.red, fg = utils.blend(colors.foreground, colors.background, 0.08) },

	-- TeSttLine
	StatusLine = { bg = utils.blend(colors.foreground, colors.background, 0.015) },
	TeSTTNormalMode = { fg = colors.blue, bg = utils.blend(colors.blue, colors.background, 0.1) },
	TeSTTVisualMode = {
		fg = utils.mix(colors.red, colors.blue, 0.5),
		bg = utils.blend(utils.mix(colors.red, colors.blue, 0.5), colors.background, 0.1),
	},
	TeSTTCommandMode = { fg = colors.red, bg = utils.blend(colors.red, colors.background, 0.1) },
	TeSTTInsertMode = { fg = colors.green, bg = utils.blend(colors.green, colors.background, 0.1) },
	TeSTTTerminalMode = { fg = colors.red, bg = utils.blend(colors.red, colors.background, 0.1) },
	TeSTTNTerminalMode = { fg = colors.red, bg = utils.blend(colors.red, colors.background, 0.1) },
	TeSTTConfirmMode = {
		fg = utils.mix(colors.red, colors.green, 0.5),
		bg = utils.blend(utils.mix(colors.red, colors.green, 0.5), colors.background, 0.1),
	},
	TeSTTNormalModeIcon = { fg = colors.background, bg = colors.blue },
	TeSTTVisualModeIcon = { fg = colors.background, bg = utils.mix(colors.red, colors.blue, 0.5) },
	TeSTTCommandModeIcon = { fg = colors.background, bg = colors.red },
	TeSTTInsertModeIcon = { fg = colors.background, bg = colors.green },
	TeSTTTerminalModeIcon = { fg = colors.background, bg = colors.red },
	TeSTTNTerminalModeIcon = { fg = colors.background, bg = colors.red },
	TeSTTConfirmModeIcon = { fg = colors.background, bg = utils.mix(colors.red, colors.green, 0.5) },

	TeSTTFileIcon = { fg = colors.background, bg = colors.red },
	TeSTTFileName = { fg = colors.red, bg = utils.blend(colors.red, colors.background, 0.1), bold = true },
	TeSTTFolder = { fg = colors.red, bg = utils.blend(colors.red, colors.background, 0.1), italic = true },

	TeSTTNothing = { bg = utils.blend(colors.foreground, colors.background, 0.015) },
	TeSTTNothing2 = { bg = colors.background },

	TeSTTLsp = { fg = colors.green, bg = utils.blend(colors.green, colors.background, 0.1) },
	TeSTTLspIcon = { fg = colors.background, bg = colors.green },
	TeSTTCopilot = {
		fg = utils.mix(colors.foreground, colors.blue, 0.7),
		bg = utils.blend(colors.green, colors.background, 0.1),
	},

	TeSTTError = { fg = colors.red, bg = utils.blend(colors.green, colors.background, 0.1) },
	TeSTTErrorIcon = { fg = colors.red, bg = utils.blend(colors.green, colors.background, 0.1) },
	TeSTTWarning = {
		fg = utils.mix(colors.red, colors.green, 0.5),
		bg = utils.blend(colors.green, colors.background, 0.1),
	},
	TeSTTWarningIcon = {
		fg = utils.mix(colors.red, colors.green, 0.5),
		bg = utils.blend(colors.green, colors.background, 0.1),
	},
	TeSTTHints = {
		fg = utils.mix(colors.red, colors.blue, 0.5),
		bg = utils.blend(colors.green, colors.background, 0.1),
	},
	TeSTTHintsIcon = {
		fg = utils.mix(colors.red, colors.blue, 0.5),
		bg = utils.blend(colors.green, colors.background, 0.1),
	},
	TeSTTInfo = { fg = colors.blue, bg = utils.blend(colors.green, colors.background, 0.1) },
	TeSTTInfoIcon = { fg = colors.blue, bg = utils.blend(colors.green, colors.background, 0.1) },

	TeSTTBranchName = {
		fg = utils.mix(colors.red, colors.blue, 0.5),
		bg = utils.blend(utils.mix(colors.red, colors.blue, 0.5), colors.background, 0.1),
	},
	TeSTTBranchIcon = { fg = colors.background, bg = utils.mix(colors.red, colors.blue, 0.5) },
	TeSTTDiffAdd = { fg = colors.green, bg = utils.blend(colors.blue, colors.background, 0.1) },
	TeSTTDiffChange = {
		fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5),
		bg = utils.blend(colors.blue, colors.background, 0.1),
	},
	TeSTTDiffRemove = { fg = colors.red, bg = utils.blend(colors.blue, colors.background, 0.1) },
	TeSTTGithub = { fg = colors.background, bg = colors.blue },

	TeSTTTabIcon = { fg = colors.background, bg = colors.red },
	TeSTTTab = { fg = colors.red, bg = utils.blend(colors.red, colors.background, 0.1) },

	TeSTTProgressIcon = { fg = colors.background, bg = utils.mix(colors.red, colors.blue, 0.5) },
	TeSTTProgress = {
		fg = utils.mix(colors.red, colors.blue, 0.5),
		bg = utils.blend(utils.mix(colors.red, colors.blue, 0.5), colors.background, 0.1),
	},

	TeSTTLocationIcon = { fg = colors.background, bg = utils.mix(colors.red, colors.green, 0.5) },
	TeSTTLocation = {
		fg = utils.mix(colors.red, colors.green, 0.5),
		bg = utils.blend(utils.mix(colors.red, colors.green, 0.5), colors.background, 0.1),
	},

	-- TeDash
	TeDashAscii = { fg = colors.background, bg = colors.blue },
	TeDashButtons = { fg = colors.foreground, bg = colors.lighter },
	TeDashBindKeys = { fg = colors.foreground, bg = colors.blue },
}
