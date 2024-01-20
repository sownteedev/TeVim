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

	-- Lsp Saga
	SagaBorder = { bg = colors.darker_black },
	SagaNormal = { bg = colors.darker_black },

	-- Indent Blankline
	IblIndent = { fg = colors.one_bg },

	-- Vim-illuminate
	IlluminatedWordText = { bold = true, underline = true },
	IlluminatedWordRead = { bold = true, underline = true },
	IlluminatedWordWrite = { bold = true, underline = true },

	-- Hop
	HopNextKey = { fg = colors.red, bold = true },
	HopNextKey1 = { fg = colors.cyan, bold = true },
	HopNextKey2 = { fg = colors.blue, bold = true },

	-- Copilot
	CopilotSuggestion = { fg = colors.light_grey, italic = true },
}
