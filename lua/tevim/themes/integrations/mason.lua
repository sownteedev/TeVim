local colors = require("tevim.themes").getCurrentTheme()

return {
	MasonHeader = { bg = colors.red, fg = colors.background },
	MasonHighlight = { fg = colors.blue },
	MasonHighlightBlock = { fg = colors.background, bg = colors.green },
	MasonHighlightBlockBold = { link = "MasonHighlightBlock" },
	MasonHeaderSecondary = { link = "MasonHighlightBlock" },
	MasonMuted = { fg = colors.grey },
	MasonMutedBlock = { fg = colors.grey },
}
