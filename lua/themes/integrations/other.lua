local colors = require("themes").getCurrentTheme()

return {
	-- SymbolOutline
	SymbolsOutlineConnector = { fg = colors.darker_black },
	FocusedSymbol = { fg = colors.white, bg = colors.black2, bold = true },

	-- Mason
	MasonHeader = { bg = colors.red, fg = colors.black },
	MasonHighlight = { fg = colors.blue },
	MasonHighlightBlock = { fg = colors.black, bg = colors.green },
	MasonHighlightBlockBold = { link = "MasonHighlightBlock" },
	MasonHeaderSecondary = { link = "MasonHighlightBlock" },
	MasonMuted = { fg = colors.light_grey },
	MasonMutedBlock = { fg = colors.light_grey, bg = colors.one_bg },

	EdgyNormal = { bg = colors.darker_black },
	EdgyWinBar = { bg = colors.darker_black },
	EdgyTitle = { bg = colors.darker_black, fg = colors.white },

	CopilotSuggestion = { fg = colors.light_grey, italic = true },
	IndentBlanklineChar = { fg = colors.one_bg },
}
