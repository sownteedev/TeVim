local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	TroubleCount = { fg = colors.red },
	TroubleCode = { fg = colors.foreground },
	TroubleWarning = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5) },
	TroubleSignWarning = { fg = utils.mix(colors.red, colors.green, 0.5) },
	TroubleTextWarning = { fg = colors.foreground },
	TroublePreview = { fg = colors.red },
	TroubleSource = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
	TroubleSignHint = { fg = colors.green },
	TroubleTextHint = { fg = colors.red },
	TroubleHint = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5) },
	TroubleSignOther = { fg = colors.green },
	TroubleSignInformation = { fg = colors.foreground },
	TroubleTextInformation = { fg = colors.blue },
	TroubleInformation = { fg = colors.foreground },
	TroubleError = { fg = colors.red },
	TroubleTextError = { fg = colors.red },
	TroubleSignError = { fg = colors.red },
	TroubleText = { fg = colors.foreground },
	TroubleFile = { fg = utils.mix(colors.red, colors.green, 0.5) },
	TroubleFoldIcon = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
	TroubleNormal = { fg = colors.foreground },
	TroubleLocation = { fg = colors.red },
	TroubleIndent = { link = "Comment" },
}
