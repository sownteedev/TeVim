local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	NoiceMini = { bg = colors.darker },
	NoiceCmdlinePopup = { bg = colors.darker },
	NoiceCmdlinePopupBorder = { bg = colors.darker, fg = colors.darker },
	NoiceCmdlinePopupBorderSearch = { link = "NoiceCmdlinePopupBorder" },
	NoiceCmdlinePopupTitle = { bg = colors.darker, fg = colors.darker },
	NoiceLspProgressSpinner = { fg = utils.blend(colors.foreground, colors.background, 0.2) },

	-- Notify
	NotifyBackground = { bg = colors.darker },
	NotifyLogTime = { bg = colors.darker },
	NotifyINFOBorder = { fg = colors.darker, bg = colors.darker },
	NotifyWARNBorder = { fg = colors.darker, bg = colors.darker },
	NotifyERRORBorder = { fg = colors.darker, bg = colors.darker },
	NotifyDEBUGBorder = { fg = colors.darker, bg = colors.darker },
	NotifyTRACEBorder = { fg = colors.darker, bg = colors.darker },
	NotifyERRORIcon = { fg = colors.red, bg = colors.darker },
	NotifyWARNIcon = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5), bg = colors.darker },
	NotifyINFOIcon = { fg = colors.blue, bg = colors.darker },
	NotifyDEBUGIcon = { fg = utils.mix(colors.foreground, colors.blue, 0.7), bg = colors.darker },
	NotifyTRACEIcon = { fg = utils.mix(colors.red, colors.blue, 0.5), bg = colors.darker },
	NotifyERRORTitle = { fg = colors.red, bg = colors.darker },
	NotifyWARNTitle = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5), bg = colors.darker },
	NotifyINFOTitle = { fg = colors.blue, bg = colors.darker },
	NotifyDEBUGTitle = { fg = utils.mix(colors.foreground, colors.blue, 0.7), bg = colors.darker },
	NotifyTRACETitle = { fg = utils.mix(colors.red, colors.blue, 0.5), bg = colors.darker },
	NotifyERRORBody = { fg = colors.red, bg = colors.darker },
	NotifyWARNBody = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5), bg = colors.darker },
	NotifyINFOBody = { fg = colors.blue, bg = colors.darker },
	NotifyDEBUGBody = { fg = utils.mix(colors.foreground, colors.blue, 0.7), bg = colors.darker },
	NotifyTRACEBody = { fg = utils.mix(colors.red, colors.blue, 0.5), bg = colors.darker },
}
