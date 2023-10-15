local colors = require("themes").getCurrentTheme()

return {
	["@boolean"] = { link = "Boolean" },
	["@annotation"] = { fg = colors.base0F },
	["@attribute"] = { fg = colors.base0A },
	["@character"] = { fg = colors.base08 },

	["@constructor"] = { fg = colors.base0C },
	["@constant"] = { fg = colors.base08 },
	["@constant.builtin"] = { fg = colors.base09 },
	["@constant.macro"] = { fg = colors.base08 },

	["@error"] = { fg = colors.base08 },
	["@exception"] = { fg = colors.base08 },
	["@float"] = { fg = colors.base09 },

	["@keyword"] = { fg = colors.base0E },
	["@keyword.function"] = { fg = colors.base0E },
	["@keyword.return"] = { fg = colors.base0E },

	["@function"] = { fg = colors.base0D },
	["@function.builtin"] = { fg = colors.base0D },
	["@function.macro"] = { fg = colors.base08 },
	["@function.call"] = { fg = colors.base0D },

	["@operator"] = { fg = colors.base05 },
	["@keyword.operator"] = { fg = colors.base0E },

	["@method"] = { fg = colors.base0D },
	["@method.call"] = { fg = colors.base0D },

	["@namespace"] = { fg = colors.base08 },
	["@none"] = { fg = colors.base05 },
	["@parameter"] = { fg = colors.base08 },
	["@reference"] = { fg = colors.base05 },

	["@punctuation.bracket"] = { fg = colors.base0F },
	["@punctuation.delimiter"] = { fg = colors.base0F },
	["@punctuation.special"] = { fg = colors.base08 },

	["@string"] = { fg = colors.base0B },
	["@string.regex"] = { fg = colors.base0C },
	["@string.escape"] = { fg = colors.base0C },
	["@string.special"] = { fg = colors.base0C },

	["@symbol"] = { fg = colors.base0B },
	["@tag"] = { link = "Tag" },
	["@tag.attribute"] = { link = "@property" },
	["@tag.delimiter"] = { fg = colors.base0F },

	["@text"] = { fg = colors.base05 },
	["@text.strong"] = { bold = true },
	["@text.emphasis"] = { fg = colors.base09 },
	["@text.strike"] = { fg = colors.base0F, strikethrough = true },
	["@text.literal"] = { fg = colors.base09 },
	["@text.uri"] = { fg = colors.base09, underline = true },

	["@type.builtin"] = { fg = colors.base0A },
	["@variable"] = { link = "Variable" },
	["@variable.builtin"] = { fg = colors.base09 },

	-- variable.global
	["@definition"] = { sp = colors.base04, underline = true },
	["@scope"] = { bold = true },
	["@field"] = { fg = colors.base08 },
	["@field.key"] = { fg = colors.base08 },
	["@property"] = { fg = colors.base08 },
	["@include"] = { link = "Include" },
	["@conditional"] = { link = "Conditional" },

	-- Set underlines for TreesitterContext
	TreesitterContext = { bg = colors.base01, bold = true },
	TreesitterContextBottom = { bold = true },
	TreesitterContextLineNumber = { fg = colors.light_grey, bold = true },

	RainbowDelimiterRed = { fg = colors.red },
	RainbowDelimiterYellow = { fg = colors.yellow },
	RainbowDelimiterBlue = { fg = colors.blue },
	RainbowDelimiterOrange = { fg = colors.orange },
	RainbowDelimiterGreen = { fg = colors.green },
	RainbowDelimiterViolet = { fg = colors.purple },
	RainbowDelimiterCyan = { fg = colors.cyan },
}
