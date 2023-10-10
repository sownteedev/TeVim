local colors = require("themes").getCurrentTheme()

return {
	DiagnosticError = { fg = colors.red, italic = true, bold = true },
	DiagnosticWarn = { fg = colors.yellow, italic = true, bold = true },
	DiagnosticInfo = { fg = colors.blue, italic = true, bold = true },
	DiagnosticHint = { fg = colors.purple, italic = true, bold = true },
	DiagnosticInformation = { fg = colors.green, italic = true, bold = true },
	LspInlayHint = { fg = colors.grey },
}
