local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	LspReferenceText = { fg = colors.darker, bg = colors.foreground },
	LspReferenceRead = { fg = colors.darker, bg = colors.foreground },
	LspReferenceWrite = { fg = colors.darker, bg = colors.foreground },

	DiagnosticError = { fg = colors.red },
	DiagnosticWarn = { fg = colors.yellow },
	DiagnosticInfo = { fg = colors.blue },
	DiagnosticHint = { fg = utils.mix(colors.red, colors.blue, 0.5) },
	DiagnosticInformation = { fg = colors.green },
	LspInlayHint = { fg = utils.blend(colors.foreground, colors.background, 0.2), bg = colors.lighter },
}
