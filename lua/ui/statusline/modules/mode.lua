local modes = {
	["n"] = { "NORMAL", "TeSTTNormalMode" },
	["niI"] = { "NORMAL i", "TeSTTNormalMode" },
	["niR"] = { "NORMAL r", "TeSTTNormalMode" },
	["niV"] = { "NORMAL v", "TeSTTNormalMode" },
	["no"] = { "N-PENDING", "TeSTTNormalMode" },
	["i"] = { "INSERT", "TeSTTInsertMode" },
	["ic"] = { "INSERT (completion)", "TeSTTInsertMode" },
	["ix"] = { "INSERT completion", "TeSTTInsertMode" },
	["t"] = { "TERMINAL", "TeSTTTerminalMode" },
	["nt"] = { "NTERMINAL", "TeSTTNTerminalMode" },
	["v"] = { "VISUAL", "TeSTTVisualMode" },
	["V"] = { "V-LINE", "TeSTTVisualMode" },
	["Vs"] = { "V-LINE (Ctrl O)", "TeSTTVisualMode" },
	[""] = { "V-BLOCK", "TeSTTVisualMode" },
	["R"] = { "REPLACE", "TeSTTReplaceMode" },
	["Rv"] = { "V-REPLACE", "TeSTTReplaceMode" },
	["s"] = { "SELECT", "TeSTTSelectMode" },
	["S"] = { "S-LINE", "TeSTTSelectMode" },
	[""] = { "S-BLOCK", "TeSTTSelectMode" },
	["c"] = { "COMMAND", "TeSTTCommandMode" },
	["cv"] = { "COMMAND", "TeSTTCommandMode" },
	["ce"] = { "COMMAND", "TeSTTCommandMode" },
	["r"] = { "PROMPT", "TeSTTConfirmMode" },
	["rm"] = { "MORE", "TeSTTConfirmMode" },
	["r?"] = { "CONFIRM", "TeSTTConfirmMode" },
	["!"] = { "SHELL", "TeSTTTerminalMode" },
}
local icon = {
	["n"] = { " ", "TeSTTNormalModeIcon" },
	["niI"] = { " ", "TeSTTNormalModeIcon" },
	["niR"] = { " ", "TeSTTNormalModeIcon" },
	["niV"] = { " ", "TeSTTNormalModeIcon" },
	["no"] = { " ", "TeSTTNormalModeIcon" },
	["i"] = { " ", "TeSTTInsertModeIcon" },
	["ic"] = { " ", "TeSTTInsertModeIcon" },
	["ix"] = { " ", "TeSTTInsertModeIcon" },
	["t"] = { " ", "TeSTTTerminalModeIcon" },
	["nt"] = { " ", "TeSTTNTerminalModeIcon" },
	["v"] = { " ", "TeSTTVisualModeIcon" },
	["V"] = { " ", "TeSTTVisualModeIcon" },
	["Vs"] = { " ", "TeSTTVisualModeIcon" },
	[""] = { " ", "TeSTTVisualModeIcon" },
	["R"] = { " ", "TeSTTReplaceModeIcon" },
	["Rv"] = { " ", "TeSTTReplaceModeIcon" },
	["s"] = { " ", "TeSTTSelectModeIcon" },
	["S"] = { " ", "TeSTTSelectModeIcon" },
	[""] = { " ", "TeSTTSelectModeIcon" },
	["c"] = { " ", "TeSTTCommandModeIcon" },
	["cv"] = { " ", "TeSTTCommandModeIcon" },
	["ce"] = { " ", "TeSTTCommandModeIcon" },
	["r"] = { " ", "TeSTTConfirmModeIcon" },
	["rm"] = { " ", "TeSTTConfirmModeIcon" },
	["r?"] = { " ", "TeSTTConfirmModeIcon" },
	["!"] = { " ", "TeSTTTerminalModeIcon" },
}

local M = function()
	local mode = vim.api.nvim_get_mode().mode
	return "%#" ..
		icon[mode][2] .. "#" .. icon[mode][1] .. " " .. "%#" .. modes[mode][2] .. "#" .. " " .. modes[mode][1] .. " ";
end

return M
