local colors = require("tevim.themes").getCurrentTheme()

return {
	LspReferenceText = { fg = colors.darker, bg = colors.foreground },
	LspReferenceRead = { fg = colors.darker, bg = colors.foreground },
	LspReferenceWrite = { fg = colors.darker, bg = colors.foreground },

	DiagnosticError = { fg = colors.red },
	DiagnosticWarn = { fg = colors.yellow },
	DiagnosticInfo = { fg = colors.blue },
	DiagnosticHint = { fg = colors.purple },
	DiagnosticInformation = { fg = colors.green },
	LspInlayHint = { fg = colors.grey, bg = colors.lighter },
}
