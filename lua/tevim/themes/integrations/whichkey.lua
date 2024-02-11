local colors = require("tevim.themes").getCurrentTheme()

return {
	WhichKey = { fg = colors.blue, bold = true },
	WhichKeySeparator = { fg = colors.light_grey },
	WhichKeyDesc = { fg = colors.red },
	WhichKeyGroup = { fg = colors.orange },
	WhichKeyValue = { fg = colors.green },
}
