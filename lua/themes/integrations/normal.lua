local colors = require("themes").getCurrentTheme()

return {
	Normal = { fg = colors.white, bg = colors.black },
	NormalNC = { fg = colors.white, bg = colors.black },
	NormalSB = { fg = colors.white, bg = colors.black },
	NormalFloat = { bg = colors.darker_black },
	FloatBorder = { fg = colors.darker_black, bg = colors.darker_black },
	WinSeparator = { fg = colors.black2, bg = colors.black },

	MsgArea = { fg = colors.white, bg = colors.black },
	ModeMsg = { fg = colors.white, bg = colors.black },
	MsgSeparator = { fg = colors.white, bg = colors.black },

	WildMenu = { fg = colors.base08, bg = colors.base0A },
	Comment = { fg = colors.grey_fg },
	Whitespace = { fg = colors.grey_fg },

	Folded = { bg = colors.black },
	FoldColumn = { bg = colors.black },

	Cursor = { fg = colors.base00, bg = colors.base05 },
	lCursor = { fg = colors.white, bg = colors.cursor },
	CursorIM = { fg = colors.white, bg = colors.cursor },
	CursorLine = { bg = colors.black2 },
	CursorLineNr = { fg = colors.purple, bold = true },
	LineNr = { fg = colors.grey_fg2, bg = colors.black },

	CursorColumn = { bg = colors.black },
	ColorColumn = { bg = colors.black },
	SignColumn = { bg = colors.black, fg = colors.black },

	Visual = { bg = colors.base02, fg = colors.white },
	VisualNOS = { fg = colors.base08, bg = colors.black },

	WarningMsg = { fg = colors.base08, bg = colors.black },
	Error = { fg = colors.base00, bg = colors.base08 },
	ErrorMsg = { fg = colors.base08, bg = colors.black },
	MoreMsg = { fg = colors.base0B, bg = colors.black },

	QuickFixLine = { bg = colors.base01, sp = "none" },
	MatchWord = { bg = colors.grey, fg = colors.white },
	MatchParen = { link = "MatchWord" },

	Exception = { fg = colors.base08 },
	Macro = { fg = colors.base08 },
	Debug = { fg = colors.base08 },

	Conceal = { bg = "none" },
	Directory = { fg = colors.base0D },
	SpecialKey = { fg = colors.base03 },
	Title = { fg = colors.base0D, sp = "none" },
	Search = { fg = colors.black, bg = colors.base0A },
	IncSearch = { fg = colors.black, bg = colors.base0A },
	Substitute = { fg = colors.base01, bg = colors.base0A, sp = "none" },
	Question = { fg = colors.purple },
	EndOfBuffer = { fg = colors.black },
	NonText = { fg = colors.base03 },

	TabLine = { fg = colors.green, bg = colors.black },
	TabLineSel = { fg = colors.white, bg = colors.black },
	TabLineFill = { fg = colors.white, bg = colors.black },

	SpellBad = { undercurl = true, sp = colors.base08 },
	SpellLocal = { undercurl = true, sp = colors.base0C },
	SpellCap = { undercurl = true, sp = colors.base0D },
	SpellRare = { undercurl = true, sp = colors.base0E },
	healthSuccess = { bg = colors.green, fg = colors.black },

	-- SynbolOutline
	SymbolsOutlineConnector = { fg = colors.black },
	FocusedSymbol = { fg = colors.white, bg = colors.black, bold = true, italic = true },

	-- Mason
	MasonHeader = { bg = colors.red, fg = colors.black },
	MasonHighlight = { fg = colors.blue },
	MasonHighlightBlock = { fg = colors.black, bg = colors.green },
	MasonHighlightBlockBold = { link = "MasonHighlightBlock" },
	MasonHeaderSecondary = { link = "MasonHighlightBlock" },
	MasonMuted = { fg = colors.light_grey },
	MasonMutedBlock = { fg = colors.light_grey, bg = colors.one_bg },

	EdgyNormal = { bg = colors.black },
}
