local colors = require("tevim.themes").getCurrentTheme()

return {
	LspReferenceText = { fg = colors.darker_black, bg = colors.white },
	LspReferenceRead = { fg = colors.darker_black, bg = colors.white },
	LspReferenceWrite = { fg = colors.darker_black, bg = colors.white },

	DiagnosticError = { fg = colors.red },
	DiagnosticWarn = { fg = colors.yellow },
	DiagnosticInfo = { fg = colors.blue },
	DiagnosticHint = { fg = colors.purple },
	DiagnosticInformation = { fg = colors.green },
	LspInlayHint = { fg = colors.grey_fg, bg = colors.black2 },
}
