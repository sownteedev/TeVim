local is_available = require("tevim.core.utils").is_available

local M = function()
	if not is_available("copilot.vim") then
		return " "
	end
	--- @diagnostic disable: deprecated
	for _, client in pairs(vim.lsp.get_active_clients()) do
		if client.name == "copilot" then
			return "%#TeSTTCopilot#" .. "    "
		end
	end
	return "%#TeSTTCopilot#" .. "     "
end

return M
