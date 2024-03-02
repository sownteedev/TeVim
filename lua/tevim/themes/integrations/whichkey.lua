local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	WhichKey = { fg = colors.blue, bold = true },
	WhichKeySeparator = { fg = colors.grey },
	WhichKeyDesc = { fg = colors.red },
	WhichKeyGroup = { fg = utils.mix(colors.red, colors.yellow, 0.5) },
	WhichKeyValue = { fg = colors.green },
}
