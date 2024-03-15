local colors = require("tevim.themes").getCurrentTheme()
local utils = require("tevim.core.utils")

local M = {}

--- General ---
local normal = {
	"Normal",
	"NormalFloat",
	"WinBar",
	"WinBarNC",
	"Folded",
	"FoldColumn",
	"LineNr",
	"CursorColumn",
	"ColorColumn",
	"SignColumn",
	"CursorLine",
	"MsgArea",
}

M.WinSeparator = {
	fg = utils.blend(colors.foreground, colors.background, 0.1),
	bg = "NONE",
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
	"TelescopeSelection",
}

M.TelescopePromptBorder = {
	fg = utils.blend(colors.foreground, colors.background, 0.1),
	bg = "NONE",
}

M.TelescopePreviewBorder = {
	fg = utils.blend(colors.foreground, colors.background, 0.1),
	bg = "NONE",
}

M.TelescopeResultsBorder = {
	fg = utils.blend(colors.foreground, colors.background, 0.1),
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
}

M.NeoTreeWinSeparator = {
	fg = utils.blend(colors.foreground, colors.background, 0.1),
	bg = "NONE",
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
	"CmpNormal",
	"CmpItemAbbr",
	"CmpItemAbbrDeprecated",
	"CmpItemMenu",
}

M.CmpBorder = {
	fg = utils.blend(colors.foreground, colors.background, 0.1),
	bg = "NONE",
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

-- Treesitter Context --
M.TreesitterContext = {
	bg = "NONE",
}

return M
