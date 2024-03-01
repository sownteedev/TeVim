local colors = require("tevim.themes").getCurrentTheme()

return {
	-- Dap
	DapBreakpoint = { fg = colors.red },
	DapBreakpointCondition = { fg = colors.yellow },
	DapLogPoint = { fg = colors.cyan },
	DapStopped = { fg = colors.red },

	-- DapUI
	DAPUIScope = { fg = colors.cyan },
	DAPUIType = { fg = colors.purple },
	DAPUIValue = { fg = colors.cyan },
	DAPUIVariable = { fg = colors.foreground },
	DapUIModifiedValue = { fg = colors.orange },
	DapUIDecoration = { fg = colors.cyan },
	DapUIThread = { fg = colors.green },
	DapUIStoppedThread = { fg = colors.cyan },
	DapUISource = { fg = colors.lavender },
	DapUILineNumber = { fg = colors.cyan },
	DapUIFloatBorder = { fg = colors.cyan },

	DapUIWatchesEmpty = { fg = colors.red },
	DapUIWatchesValue = { fg = colors.green },
	DapUIWatchesError = { fg = colors.red },

	DapUIBreakpointsPath = { fg = colors.cyan },
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
