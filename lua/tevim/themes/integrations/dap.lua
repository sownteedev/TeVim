local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	-- Dap
	DapBreakpoint = { fg = colors.red },
	DapBreakpointCondition = { fg = colors.yellow },
	DapLogPoint = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
	DapStopped = { fg = colors.red },

	-- DapUI
	DAPUIScope = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
	DAPUIType = { fg = utils.mix(colors.red, colors.blue, 0.5) },
	DAPUIValue = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
	DAPUIVariable = { fg = colors.foreground },
	DapUIModifiedValue = { fg = utils.mix(colors.red, colors.yellow, 0.5) },
	DapUIDecoration = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
	DapUIThread = { fg = colors.green },
	DapUIStoppedThread = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
	DapUISource = { fg = colors.lavender },
	DapUILineNumber = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
	DapUIFloatBorder = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },

	DapUIWatchesEmpty = { fg = colors.red },
	DapUIWatchesValue = { fg = colors.green },
	DapUIWatchesError = { fg = colors.red },

	DapUIBreakpointsPath = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
	DapUIBreakpointsInfo = { fg = colors.green },
	DapUIBreakPointsCurrentLine = { fg = colors.green, bold = true },
	DapUIBreakpointsDisabledLine = { fg = colors.grey },

	DapUIStepOver = { fg = colors.blue },
	DapUIStepOverNC = { fg = colors.blue },
	DapUIStepInto = { fg = colors.blue },
	DapUIStepIntoNC = { fg = colors.blue },
	DapUIStepBack = { fg = colors.blue },
	DapUIStepBackNC = { fg = colors.blue },
	DapUIStepOut = { fg = colors.blue },
	DapUIStepOutNC = { fg = colors.blue },
	DapUIStop = { fg = colors.red },
	DapUIStopNC = { fg = colors.red },
	DapUIPlayPause = { fg = colors.green },
	DapUIPlayPauseNC = { fg = colors.green },
	DapUIRestart = { fg = colors.green },
	DapUIRestartNC = { fg = colors.green },
	DapUIUnavailable = { fg = colors.grey },
	DapUIUnavailableNC = { fg = colors.grey },
}
