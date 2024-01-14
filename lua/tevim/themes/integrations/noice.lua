local colors = require("tevim.themes").getCurrentTheme()

return {
	NoiceMini = { bg = colors.darker_black },
	NoiceCmdlinePopup = { bg = colors.darker_black },
	NoiceCmdlinePopupBorder = { bg = colors.darker_black, fg = colors.darker_black },
	NoiceCmdlinePopupBorderSearch = { link = "NoiceCmdlinePopupBorder" },
	NoiceCmdlinePopupTitle = { bg = colors.darker_black, fg = colors.darker_black },
	NoiceLspProgressSpinner = { fg = colors.grey_fg },

	-- Notify
	NotifyBackground = { bg = colors.darker_black },
	NotifyLogTime = { bg = colors.darker_black },
	NotifyINFOBorder = { fg = colors.darker_black, bg = colors.darker_black },
	NotifyWARNBorder = { fg = colors.darker_black, bg = colors.darker_black },
	NotifyERRORBorder = { fg = colors.darker_black, bg = colors.darker_black },
	NotifyDEBUGBorder = { fg = colors.darker_black, bg = colors.darker_black },
	NotifyTRACEBorder = { fg = colors.darker_black, bg = colors.darker_black },
	NotifyERRORIcon = { fg = colors.red, bg = colors.darker_black },
	NotifyWARNIcon = { fg = colors.orange, bg = colors.darker_black },
	NotifyINFOIcon = { fg = colors.blue, bg = colors.darker_black },
	NotifyDEBUGIcon = { fg = colors.cyan, bg = colors.darker_black },
	NotifyTRACEIcon = { fg = colors.purple, bg = colors.darker_black },
	NotifyERRORTitle = { fg = colors.red, bg = colors.darker_black },
	NotifyWARNTitle = { fg = colors.orange, bg = colors.darker_black },
	NotifyINFOTitle = { fg = colors.blue, bg = colors.darker_black },
	NotifyDEBUGTitle = { fg = colors.cyan, bg = colors.darker_black },
	NotifyTRACETitle = { fg = colors.purple, bg = colors.darker_black },
	NotifyERRORBody = { fg = colors.red, bg = colors.darker_black },
	NotifyWARNBody = { fg = colors.orange, bg = colors.darker_black },
	NotifyINFOBody = { fg = colors.blue, bg = colors.darker_black },
	NotifyDEBUGBody = { fg = colors.cyan, bg = colors.darker_black },
	NotifyTRACEBody = { fg = colors.purple, bg = colors.darker_black },
}
