local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	LazyH1 = { bg = colors.green, fg = colors.background },
	LazyButton = { bg = utils.blend(colors.foreground, colors.background, 0.1), fg = colors.foreground },
	LazyButtonActive = { bg = utils.blend(colors.foreground, colors.background, 0.2), fg = colors.foreground },
	LazyH2 = { fg = colors.red, bold = true },
	LazyReasonPlugin = { fg = colors.red },
	LazyValue = { fg = colors.blue },
	LazyDir = { fg = colors.base05 },
	LazyUrl = { fg = colors.base05 },
	LazyCommit = { fg = colors.green },
	LazyNoCond = { fg = colors.red },
	LazySpecial = { fg = colors.blue },
	LazyReasonFt = { fg = utils.mix(colors.red, colors.blue, 0.5) },
	LazyOperator = { fg = colors.foreground },
	LazyReasonKeys = { fg = colors.blue },
	LazyTaskOutput = { fg = colors.foreground },
	LazyCommitIssue = { fg = colors.red },
	LazyReasonEvent = { fg = utils.mix(colors.red, colors.green, 0.5) },
	LazyReasonStart = { fg = colors.foreground },
	LazyReasonRuntime = { fg = colors.blue },
	LazyReasonCmd = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.5) },
	LazyReasonSource = { fg = utils.mix(colors.foreground, colors.blue, 0.7) },
	LazyReasonImport = { fg = colors.foreground },
	LazyProgressDone = { fg = colors.green },
	LazyProgressTodo = { fg = utils.blend(colors.foreground, colors.background, 0.3), bg = colors.darker },
}
