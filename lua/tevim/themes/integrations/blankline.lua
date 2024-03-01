local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	-- For ibl version
	IblScope = { fg = utils.blend(colors.foreground, colors.background, 0.05) },
	IblIndent = { fg = utils.blend(colors.foreground, colors.background, 0.05) },
	IblWhitespace = { fg = utils.blend(colors.foreground, colors.background, 0.05) },

	-- For 2.20.7 version
	IndentBlanklineChar = { fg = utils.blend(colors.foreground, colors.background, 0.05) },
	IndentBlanklineSpaceChar = { fg = utils.blend(colors.foreground, colors.background, 0.05) },
	IndentBlanklineContextChar = { fg = utils.blend(colors.foreground, colors.background, 0.05) },
	IndentBlanklineContextStart = { bg = utils.blend(colors.foreground, colors.background, 0.05) },

	-- Mini Indent (mini.nvim)
	MiniIndentscopeSymbol = { fg = utils.blend(colors.foreground, colors.background, 0.15) },
}
