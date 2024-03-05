local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	-- For ibl version
	IblScope = { fg = utils.blend(colors.foreground, colors.background, 0.02) },
	IblIndent = { fg = utils.blend(colors.foreground, colors.background, 0.02) },
	IblWhitespace = { fg = utils.blend(colors.foreground, colors.background, 0.02) },

	-- For 2.20.7 version
	IndentBlanklineChar = { fg = utils.blend(colors.foreground, colors.background, 0.02) },
	IndentBlanklineSpaceChar = { fg = utils.blend(colors.foreground, colors.background, 0.02) },
	IndentBlanklineContextChar = { fg = utils.blend(colors.foreground, colors.background, 0.02) },
	IndentBlanklineContextStart = { bg = utils.blend(colors.foreground, colors.background, 0.02) },

	-- Mini Indent (mini.nvim)
	MiniIndentscopeSymbol = { fg = utils.blend(colors.foreground, colors.background, 0.1) },
}
