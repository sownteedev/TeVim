local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	TroubleCount = { fg = colors.red },
	TroubleCode = { fg = colors.foreground },
	TroubleWarning = { fg = utils.mix(colors.red, colors.yellow, 0.5) },
	TroubleSignWarning = { fg = colors.yellow },
	TroubleTextWarning = { fg = colors.foreground },
	TroublePreview = { fg = colors.red },
	TroubleSource = { fg = colors.cyan },
	TroubleSignHint = { fg = colors.green },
	TroubleTextHint = { fg = colors.red },
	TroubleHint = { fg = utils.mix(colors.red, colors.yellow, 0.5) },
	TroubleSignOther = { fg = colors.green },
	TroubleSignInformation = { fg = colors.foreground },
	TroubleTextInformation = { fg = colors.blue },
	TroubleInformation = { fg = colors.foreground },
	TroubleError = { fg = colors.red },
	TroubleTextError = { fg = colors.red },
	TroubleSignError = { fg = colors.red },
	TroubleText = { fg = colors.foreground },
	TroubleFile = { fg = colors.yellow },
	TroubleFoldIcon = { fg = colors.cyan },
	TroubleNormal = { fg = colors.foreground },
	TroubleLocation = { fg = colors.red },
	TroubleIndent = { link = "Comment" },
}
