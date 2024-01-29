local colors = require("tevim.themes").getCurrentTheme()

return {
	IndentBlanklineChar = { fg = colors.one_bg },
	IndentBlanklineContextChar = { fg = colors.one_bg3 },

	IblIndent = { fg = colors.one_bg },
	IblScopeChar = { fg = colors.one_bg3 },
	IblScopeFirstLine = { bg = colors.one_bg },
}
