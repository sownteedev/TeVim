local colors = require("tevim.themes").getCurrentTheme()

local M = {}

--- General ---
local normal = {
	"NormalFloat",
	"Normal",
	"NormalNC",
	"WinBar",
	"WinBarNC",
	"Folded",
	"FoldColumn",
	"LineNr",
	"CursorColumn",
	"ColorColumn",
	"SignColumn",
	"CursorLine",
}

M.WinSeparator = {
	fg = colors.one_bg2,
	bg = colors.none,
}

for _, normal_hl in ipairs(normal) do
	M[normal_hl] = {
		bg = colors.none,
	}
end

--- UI ---
local ui = {
	"StatusLine",
	"StatusLineNC",
	"TeSTTNothing",
	"TeSTTNothing2",
	"TeBufOnInactive",
	"TeBufOnActive",
	"TeBufOnClose",
	"TeBufOffClose",
	"TeBufEmptyColor",
	"TeBufOffModified",
	"TeBufEmpty",
	"TeBufTree",
}

for _, ui_hl in ipairs(ui) do
	M[ui_hl] = {
		bg = colors.none,
	}
end

--- Telescope ---
local telescope = {
	"TelescopeNormal",
	"TelescopePrompt",
	"TelescopeBorder",
	"TelescopeResults",
	"TelescopePromptNormal",
	"TelescopePromptPrefix",
	"TelescopeSelection",
}

M.TelescopePromptBorder = {
	fg = colors.one_bg2,
	bg = colors.none,
}

M.TelescopePreviewBorder = {
	fg = colors.one_bg2,
	bg = colors.none,
}

M.TelescopeResultsBorder = {
	fg = colors.one_bg2,
	bg = colors.none,
}

for _, telescope_hl in ipairs(telescope) do
	M[telescope_hl] = {
		bg = colors.none,
	}
end

--- NeoTree ---
local tree = {
	"NeoTreeNormal",
	"NeoTreeNormalNC",
}

M.NeoTreeWinSeparator = {
	fg = colors.one_bg2,
	bg = colors.none,
}

for _, tree_hl in ipairs(tree) do
	M[tree_hl] = {
		bg = colors.none,
	}
end

--- WhichKey ---
local whichkey = {
	"WhichKey",
	"WhichKeyGroup",
	"WhichKeyDesc",
	"WhichKeyFloat",
}

for _, whichkey_hl in ipairs(whichkey) do
	M[whichkey_hl] = {
		bg = colors.none,
	}
end

--- CMP ---
local cmp = {
	"CmpNormal",
	"CmpItemAbbr",
	"CmpItemAbbrDeprecated",
	"CmpItemMenu",
}

M.CmpBorder = {
	fg = colors.one_bg2,
	bg = colors.none,
}

M.CmpItemAbbrMatch = {
	bg = colors.none,
	bold = true,
}

for _, cmp_hl in ipairs(cmp) do
	M[cmp_hl] = {
		bg = colors.none,
	}
end

--- Noice ---
local noice = {
	"NoiceMini",
	"NoiceCmdlinePopup",
	"NoiceCmdlinePopupBorder",
	"NoiceCmdlinePopupBorderSearch",
	"NoiceCmdlinePopupTitle",
	"NotifyBackground",
	"NotifyINFOBorder",
	"NotifyWARNBorder",
	"NotifyERRORBorder",
	"NotifyDEBUGBorder",
	"NotifyTRACEBorder",
	"NotifyLogTime",
	"NotifyERRORIcon",
	"NotifyWARNIcon",
	"NotifyINFOIcon",
	"NotifyDEBUGIcon",
	"NotifyTRACEIcon",
	"NotifyERRORTitle",
	"NotifyWARNTitle",
	"NotifyINFOTitle",
	"NotifyDEBUGTitle",
	"NotifyTRACETitle",
	"NotifyERRORBody",
	"NotifyWARNBody",
	"NotifyINFOBody",
	"NotifyDEBUGBody",
	"NotifyTRACEBody",
}

for _, noice_hl in ipairs(noice) do
	M[noice_hl] = {
		bg = colors.none,
	}
end

-- Treesitter Context --
M.TreesitterContext = {
	bg = colors.none,
}

return M
