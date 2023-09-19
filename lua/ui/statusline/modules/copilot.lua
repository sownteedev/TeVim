local M = function()
	if vim.o.columns < 130 then
		return ""
	end
	--- @diagnostic disable: deprecated
	for _, client in pairs(vim.lsp.get_active_clients()) do
		if client.name == "copilot" then
			return "%#TeSTTCopilot#" .. "   "
		end
	end
	return "%#TeSTTCopilot#" .. "   "
end

return M
