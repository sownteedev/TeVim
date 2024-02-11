local colors = require("tevim.themes").getCurrentTheme()

return {
	-- For ibl version
	IblScope = { fg = colors.one_bg },
	IblIndent = { fg = colors.one_bg },
	IblWhitespace = { fg = colors.one_bg2 },

	-- For 2.20.7 version
	IndentBlanklineChar = { fg = colors.one_bg },
	IndentBlanklineSpaceChar = { fg = colors.one_bg },
	IndentBlanklineContextChar = { fg = colors.one_bg2 },
	IndentBlanklineContextStart = { bg = colors.one_bg2 },

	-- Mini Indent (mini.nvim)
	MiniIndentscopeSymbol = { fg = colors.grey },
}
