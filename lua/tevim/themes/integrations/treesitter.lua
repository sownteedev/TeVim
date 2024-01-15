local colors = require("tevim.themes").getCurrentTheme()

return {
	["@annotation"] = { fg = colors.base0F },
	["@attribute"] = { fg = colors.base0A },
	["@character"] = { fg = colors.base08 },

	["@constructor"] = { fg = colors.base0C },
	["@constant"] = { fg = colors.base08 },
	["@constant.builtin"] = { fg = colors.base09 },
	["@constant.macro"] = { fg = colors.base08 },

	["@error"] = { fg = colors.base08 },
	["@number.float"] = { fg = colors.base09 },

	["@keyword"] = { fg = colors.base0E },
	["@keyword.function"] = { fg = colors.base0E },
	["@keyword.exception"] = { fg = colors.base08 },
	["@keyword.return"] = { fg = colors.base0E },

	["@function"] = { fg = colors.base0D },
	["@function.builtin"] = { fg = colors.base0D },
	["@function.macro"] = { fg = colors.base08 },
	["@function.call"] = { fg = colors.base0D },

	["@operator"] = { fg = colors.base05 },
	["@keyword.operator"] = { fg = colors.base0E },

	["@function.method"] = { fg = colors.base0D },
	["@function.method.call"] = { fg = colors.base0D },
	["@module"] = { fg = colors.base08 },

	["@namespace"] = { fg = colors.base08 },
	["@none"] = { fg = colors.base05 },
	["@variable.parameter"] = { fg = colors.base08 },
	["@reference"] = { fg = colors.base05 },

	["@punctuation.bracket"] = { fg = colors.base0F },
	["@punctuation.delimiter"] = { fg = colors.base0F },

	["@string"] = { fg = colors.base0B },
	["@string.regex"] = { fg = colors.base0C },
	["@string.escape"] = { fg = colors.base0C },

	["@symbol"] = { fg = colors.base0B },
	["@tag"] = { link = "Tag" },
	["@tag.attribute"] = { link = "@property" },
	["@tag.delimiter"] = { fg = colors.base0F },

	["@text"] = { fg = colors.base05 },
	["@text.strong"] = { bold = true },
	["@text.emphasis"] = { fg = colors.base09 },
	["@text.strike"] = { fg = colors.base0F, strikethrough = true },
	["@string.special.url"] = { fg = colors.base09, underline = true },

	["@type.builtin"] = { fg = colors.base0A },
	["@variable"] = { link = "Variable" },
	["@variable.builtin"] = { fg = colors.base09 },
	["@variable.member"] = { fg = colors.base08 },
	["@variable.member.key"] = { fg = colors.base08 },

	["@definition"] = { sp = colors.base04, underline = true },
	["@scope"] = { bold = true },
	["@property"] = { fg = colors.base08 },
	["@keyword.import"] = { link = "Include" },
	["@keyword.conditional"] = { fg = colors.base0E },
	["@keyword.conditional.ternary"] = { fg = colors.base0E },
	["@keyword.repeat"] = { fg = colors.base0A },
	["@keyword.storage"] = { fg = colors.base0A },
	["@keyword.directive.define"] = { fg = colors.base0E },
	["@keyword.directive"] = { fg = colors.base0A },

	["@markup.heading"] = { fg = colors.base0D },
	["@markup.raw"] = { fg = colors.base09 },
	["@markup.link"] = { fg = colors.base08 },
	["@markup.link.url"] = { fg = colors.base09, underline = true },
	["@markup.link.label"] = { fg = colors.base0C },
	["@markup.list"] = { fg = colors.base08 },
	["@markup.strong"] = { bold = true },
	["@markup.italic"] = { italic = true },
	["@markup.strikethrough"] = { strikethrough = true },

	["@comment"] = { fg = colors.grey_fg },
	["@comment.todo"] = { fg = colors.grey, bg = colors.white },
	["@comment.warning"] = { fg = colors.black2, bg = colors.base09 },
	["@comment.note"] = { fg = colors.black2, bg = colors.white },
	["@comment.danger"] = { fg = colors.black2, bg = colors.red },

	["@diff.plus"] = { fg = colors.green },
	["@diff.minus"] = { fg = colors.red },
	["@diff.delta"] = { fg = colors.light_grey },

	-- TreesitterContext
	TreesitterContext = { bg = colors.base01, bold = true },
	TreesitterContextBottom = { bold = true },
	TreesitterContextLineNumber = { fg = colors.light_grey, bold = true },

	-- Rainbow Brackets
	RainbowDelimiterRed = { fg = colors.red },
	RainbowDelimiterYellow = { fg = colors.yellow },
	RainbowDelimiterBlue = { fg = colors.blue },
	RainbowDelimiterOrange = { fg = colors.orange },
	RainbowDelimiterGreen = { fg = colors.green },
	RainbowDelimiterViolet = { fg = colors.purple },
	RainbowDelimiterCyan = { fg = colors.cyan },
}
