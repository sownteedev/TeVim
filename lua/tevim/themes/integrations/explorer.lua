local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	NeoTreeNormal = { bg = colors.darker },
	NeoTreeNormalNC = { bg = colors.darker },
	NeoTreeWinSeparator = { bg = colors.background, fg = colors.background },
	NeoTreeIndentMarker = { fg = utils.blend(colors.foreground, colors.background, 0.02) },
	NeoTreeExpander = { fg = utils.blend(colors.foreground, colors.background, 0.1) },
	NeoTreeDirectoryIcon = { fg = colors.blue },
	NeoTreeRootName = { fg = colors.blue, bold = true },
	NeoTreeModified = { fg = colors.green },

	NeoTreeGitAdded = { fg = colors.green },
	NeoTreeGitConflict = { fg = colors.red },
	NeoTreeGitDeleted = { fg = colors.red },
	NeoTreeGitIgnored = { fg = utils.blend(colors.foreground, colors.background, 0.2) },
	NeoTreeGitModified = { fg = utils.mix(colors.red, colors.yellow, 0.5) },
	NeoTreeGitUnstaged = { fg = colors.red },
	NeoTreeGitUntracked = { fg = colors.green },
	NeoTreeGitStaged = { fg = colors.green },
}
