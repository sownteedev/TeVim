local colors = require("tevim.themes").getCurrentTheme()

return {
	NoiceMini = { bg = colors.darker },
	NoiceCmdlinePopup = { bg = colors.darker },
	NoiceCmdlinePopupBorder = { bg = colors.darker, fg = colors.darker },
	NoiceCmdlinePopupBorderSearch = { link = "NoiceCmdlinePopupBorder" },
	NoiceCmdlinePopupTitle = { bg = colors.darker, fg = colors.darker },
	NoiceLspProgressSpinner = { fg = colors.grey },

	-- Notify
	NotifyBackground = { bg = colors.darker },
	NotifyLogTime = { bg = colors.darker },
	NotifyINFOBorder = { fg = colors.darker, bg = colors.darker },
	NotifyWARNBorder = { fg = colors.darker, bg = colors.darker },
	NotifyERRORBorder = { fg = colors.darker, bg = colors.darker },
	NotifyDEBUGBorder = { fg = colors.darker, bg = colors.darker },
	NotifyTRACEBorder = { fg = colors.darker, bg = colors.darker },
	NotifyERRORIcon = { fg = colors.red, bg = colors.darker },
	NotifyWARNIcon = { fg = colors.orange, bg = colors.darker },
	NotifyINFOIcon = { fg = colors.blue, bg = colors.darker },
	NotifyDEBUGIcon = { fg = colors.cyan, bg = colors.darker },
	NotifyTRACEIcon = { fg = colors.purple, bg = colors.darker },
	NotifyERRORTitle = { fg = colors.red, bg = colors.darker },
	NotifyWARNTitle = { fg = colors.orange, bg = colors.darker },
	NotifyINFOTitle = { fg = colors.blue, bg = colors.darker },
	NotifyDEBUGTitle = { fg = colors.cyan, bg = colors.darker },
	NotifyTRACETitle = { fg = colors.purple, bg = colors.darker },
	NotifyERRORBody = { fg = colors.red, bg = colors.darker },
	NotifyWARNBody = { fg = colors.orange, bg = colors.darker },
	NotifyINFOBody = { fg = colors.blue, bg = colors.darker },
	NotifyDEBUGBody = { fg = colors.cyan, bg = colors.darker },
	NotifyTRACEBody = { fg = colors.purple, bg = colors.darker },
}
