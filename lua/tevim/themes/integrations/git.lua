local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

return {
	-- GitSigns
	GitSignsAdd = { fg = colors.green },
	GitSignsAdded = { fg = colors.blue },
	GitSignsChange = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.8) },
	GitSignsDelete = { fg = colors.red },
	GitSignsCurrentLineBlame = { fg = utils.blend(colors.foreground, colors.background, 0.15) },

	diffOldFile = { fg = colors.red },
	diffNewFile = { fg = colors.blue },

	DiffAdd = { fg = colors.green },
	DiffAdded = { fg = colors.blue },
	DiffChange = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.8) },
	DiffChangeDelete = { fg = colors.red },
	DiffModified = { fg = utils.mix(colors.red, utils.mix(colors.red, colors.green, 0.5), 0.8) },
	DiffDelete = { fg = colors.red },
	DiffRemoved = { fg = colors.red },
	DiffText = { fg = colors.foreground, bg = colors.lighter },

	-- git commits
	gitcommitOverflow = { fg = colors.base08 },
	gitcommitSummary = { fg = colors.base0B },
	gitcommitComment = { fg = colors.base03 },
	gitcommitUntracked = { fg = colors.base03 },
	gitcommitDiscarded = { fg = colors.base03 },
	gitcommitSelected = { fg = colors.base03 },
	gitcommitHeader = { fg = colors.base0E },
	gitcommitSelectedType = { fg = colors.base0D },
	gitcommitUnmergedType = { fg = colors.base0D },
	gitcommitDiscardedType = { fg = colors.base0D },
	gitcommitBranch = { fg = colors.base09, bold = true },
	gitcommitUntrackedFile = { fg = colors.base0A },
	gitcommitUnmergedFile = { fg = colors.base08, bold = true },
	gitcommitDiscardedFile = { fg = colors.base08, bold = true },
	gitcommitSelectedFile = { fg = colors.base0B, bold = true },
}
