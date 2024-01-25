local colors = require("tevim.themes").getCurrentTheme()

return {
	GitSignsCurrentLineBlame = { fg = colors.grey_fg },

	diffOldFile = { fg = colors.baby_pink },
	diffNewFile = { fg = colors.blue },

	DiffAdd = { fg = colors.green },
	DiffAdded = { fg = colors.blue },
	DiffChange = { fg = colors.orange },
	DiffChangeDelete = { fg = colors.red },
	DiffModified = { fg = colors.orange },
	DiffDelete = { fg = colors.red },
	DiffRemoved = { fg = colors.red },
	DiffText = { fg = colors.white, bg = colors.black2 },

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
