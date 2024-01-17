local colors = require("tevim.themes").getCurrentTheme()

return {
	-- Mason
	MasonHeader = { bg = colors.red, fg = colors.black },
	MasonHighlight = { fg = colors.blue },
	MasonHighlightBlock = { fg = colors.black, bg = colors.green },
	MasonHighlightBlockBold = { link = "MasonHighlightBlock" },
	MasonHeaderSecondary = { link = "MasonHighlightBlock" },
	MasonMuted = { fg = colors.light_grey },
	MasonMutedBlock = { fg = colors.light_grey, bg = colors.one_bg },

	CopilotSuggestion = { fg = colors.light_grey, italic = true },
	IblIndent = { fg = colors.one_bg },
}
