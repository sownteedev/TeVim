local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	TodoBgFix = { fg = colors.lighter, bg = colors.red, bold = true },
	TodoBgHack = { fg = colors.lighter, bg = utils.mix(colors.red, colors.green, 0.5), bold = true },
	TodoBgNote = { fg = colors.lighter, bg = colors.foreground, bold = true },
	TodoBgPerf = { fg = colors.lighter, bg = utils.mix(colors.red, colors.blue, 0.5), bold = true },
	TodoBgTest = { fg = colors.lighter, bg = colors.green, bold = true },
	TodoBgTodo = { fg = colors.lighter, bg = colors.blue, bold = true },
	TodoBgWarn = {
		fg = colors.lighter,
		bg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5),
		bold = true,
	},
	TodoFgFix = { fg = colors.red },
	TodoFgHack = { fg = utils.mix(colors.red, colors.green, 0.5) },
	TodoFgNote = { fg = colors.foreground },
	TodoFgPerf = { fg = utils.mix(colors.red, colors.blue, 0.5) },
	TodoFgTest = { fg = colors.green },
	TodoFgTodo = { fg = colors.blue },
	TodoFgWarn = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5) },
	TodoSignFix = { link = "TodoFgFix" },
	TodoSignHack = { link = "TodoFgHack" },
	TodoSignNote = { link = "TodoFgNote" },
	TodoSignPerf = { link = "TodoFgPerf" },
	TodoSignTest = { link = "TodoFgTest" },
	TodoSignTodo = { link = "TodoFgTodo" },
	TodoSignWarn = { link = "TodoFgWarn" },
}
