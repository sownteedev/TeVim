local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	WhichKey = { fg = colors.blue, bold = true },
	WhichKeySeparator = { fg = utils.blend(colors.foreground, colors.background, 0.2) },
	WhichKeyDesc = { fg = colors.red },
	WhichKeyGroup = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5) },
	WhichKeyValue = { fg = colors.green },
}
