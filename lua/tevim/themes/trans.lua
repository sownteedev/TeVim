local colors = require("tevim.themes").getCurrentTheme()

local M = {}

--- General ---
local normal = {
	"NormalFloat",
	"Normal",
	"NormalNC",
	"WinBar",
	"WinBarNC",
	"WinSeparator",
	"Folded",
	"FoldColumn",
	"LineNr",
	"CursorColumn",
	"ColorColumn",
	"SignColumn",
	"CursorLine",
}

for _, normal_hl in ipairs(normal) do
	M[normal_hl] = {
		bg = "NONE",
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
		bg = "NONE",
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
	"TelescopeMatching",
	"TelescopePreviewBorder",
	"TelescopeResultsBorder",
}

M.TelescopePromptBorder = {
	fg = colors.darker_black,
	bg = "NONE",
}
for _, telescope_hl in ipairs(telescope) do
	M[telescope_hl] = {
		bg = "NONE",
	}
end

--- NeoTree ---
local tree = {
	"NeoTreeNormal",
	"NeoTreeNormalNC",
	"NeoTreeWinSeparator",
}

for _, tree_hl in ipairs(tree) do
	M[tree_hl] = {
		bg = "NONE",
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
		bg = "NONE",
	}
end

--- CMP ---
local cmp = {
	"Pmenu",
	"PmenuBorder",
	"PmenuSbar",
	"CmpItemAbbr",
	"CmpItemAbbrDeprecated",
	"CmpItemMenu",
}

M.CmpItemAbbrMatch = {
	bg = "NONE",
	bold = true,
}

for _, cmp_hl in ipairs(cmp) do
	M[cmp_hl] = {
		bg = "NONE",
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
		bg = "NONE",
	}
end

return M
