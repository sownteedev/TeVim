local colors = require("tevim.themes").getCurrentTheme()

return {
	TelescopeBackground = { bg = colors.darker_black },
	TelescopeNormal = { bg = colors.darker_black },
	TelescopeBorder = { fg = colors.darker_black, bg = colors.darker_black },

	TelescopePromptBorder = { fg = colors.black2, bg = colors.black2 },
	TelescopePromptNormal = { fg = colors.white, bg = colors.black2 },
	TelescopePromptTitle = { fg = colors.black, bg = colors.red },

	TelescopePreviewTitle = { fg = colors.black2, bg = colors.blue },
	TelescopePreviewBorder = { bg = colors.darker_black, fg = colors.darker_black },

	TelescopeResultsTitle = { fg = colors.black2, bg = colors.green },
	TelescopeResultsBorder = { bg = colors.darker_black, fg = colors.darker_black },

	TelescopeMatching = { bold = true },
	TelescopeSelection = { bg = colors.black2, fg = colors.teal },
	TelescopeResultsDiffAdd = { fg = colors.green },
	TelescopeResultsDiffChange = { fg = colors.blue },
	TelescopeResultsDiffDelete = { fg = colors.red },
}
