local colors = require("tevim.themes").getCurrentTheme()

return {
	TelescopeBackground = { bg = colors.darker },
	TelescopeNormal = { bg = colors.darker },
	TelescopeBorder = { fg = colors.darker, bg = colors.darker },

	TelescopePromptBorder = { fg = colors.lighter, bg = colors.lighter },
	TelescopePromptNormal = { fg = colors.foreground, bg = colors.lighter },
	TelescopePromptTitle = { fg = colors.black, bg = colors.red },

	TelescopePreviewTitle = { fg = colors.lighter, bg = colors.blue },
	TelescopePreviewBorder = { bg = colors.darker, fg = colors.darker },

	TelescopeResultsTitle = { fg = colors.lighter, bg = colors.green },
	TelescopeResultsBorder = { bg = colors.darker, fg = colors.darker },

	TelescopeMatching = { bold = true },
	TelescopeSelection = { bg = colors.lighter, fg = colors.blue },
	TelescopeResultsDiffAdd = { fg = colors.green },
	TelescopeResultsDiffChange = { fg = colors.blue },
	TelescopeResultsDiffDelete = { fg = colors.red },
}
