local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	Normal = { fg = colors.foreground, bg = colors.background },
	NormalNC = { fg = colors.foreground, bg = colors.background },
	NormalSB = { fg = colors.foreground, bg = colors.background },
	NormalFloat = { bg = colors.darker },
	FloatBorder = { fg = colors.darker, bg = colors.darker },
	WinSeparator = { fg = colors.lighter, bg = colors.background },
	WinBar = { bg = colors.background },
	WinBarNC = { bg = colors.background },

	Pmenu = { bg = utils.blend(colors.foreground, colors.background, 0.05) },
	PmenuSbar = { bg = utils.blend(colors.foreground, colors.background, 0.05) },
	PmenuSel = { bg = colors.green, fg = colors.background },
	PmenuThumb = { bg = colors.lighter },

	ModeMsg = { fg = colors.foreground },
	MsgSeparator = { fg = colors.foreground, bg = colors.background },

	WildMenu = { fg = colors.base08, bg = colors.base0A },
	Comment = { fg = utils.blend(colors.foreground, colors.background, 0.2), italic = true },
	Whitespace = { fg = utils.blend(colors.foreground, colors.background, 0.2) },

	Folded = { fg = utils.blend(colors.foreground, colors.background, 0.15), bg = colors.background },
	FoldColumn = { fg = utils.blend(colors.foreground, colors.background, 0.15), bg = colors.background },

	Cursor = { fg = colors.base00, bg = colors.base05 },
	CursorLine = { bg = utils.blend(colors.foreground, colors.background, 0.015) },
	CursorLineNr = { fg = colors.foreground, bold = true },
	LineNr = { fg = utils.blend(colors.foreground, colors.background, 0.15), bg = colors.background },

	CursorColumn = { bg = colors.background },
	ColorColumn = { bg = colors.background },
	SignColumn = { bg = colors.background, fg = colors.background },

	Visual = { bg = colors.base03, fg = colors.foreground },
	VisualNOS = { fg = colors.base08, bg = colors.background },

	WarningMsg = { fg = colors.base08 },
	Error = { fg = colors.base00, bg = colors.base08 },
	ErrorMsg = { fg = colors.base08 },
	MoreMsg = { fg = colors.base0B },

	QuickFixLine = { bg = colors.base01, sp = colors.none },
	MatchWord = { bg = colors.lighter, fg = colors.foreground },
	MatchParen = { link = "MatchWord" },

	Exception = { fg = colors.base08 },
	Macro = { fg = colors.base08 },
	Debug = { fg = colors.base08 },

	Conceal = { bg = colors.none },
	Directory = { fg = colors.base0D },
	SpecialKey = { fg = colors.base03 },
	Title = { fg = colors.base0D, sp = colors.none },
	Search = { fg = colors.background, bg = colors.base0A },
	IncSearch = { fg = colors.background, bg = colors.base0A },
	Substitute = { fg = colors.base01, bg = colors.base0A, sp = colors.none },
	Question = { fg = utils.mix(colors.red, colors.blue, 0.5) },
	EndOfBuffer = { fg = colors.background },
	NonText = { fg = colors.base03 },

	TabLine = { fg = colors.green, bg = colors.background },
	TabLineSel = { fg = colors.foreground, bg = colors.background },
	TabLineFill = { fg = colors.foreground, bg = colors.background },

	SpellBad = { undercurl = true, sp = colors.base08 },
	SpellLocal = { undercurl = true, sp = colors.base0C },
	SpellCap = { undercurl = true, sp = colors.base0D },
	SpellRare = { undercurl = true, sp = colors.base0E },
	healthSuccess = { bg = colors.green, fg = colors.background },
}
