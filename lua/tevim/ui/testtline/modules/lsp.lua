local M = function()
	local buf_clients = vim.lsp.get_active_clients()
	if not buf_clients then
		return ""
	end
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	if next(buf_clients) == nil then
		return ""
	end

	-- ADD CLIENTS
	local add_client = function(filetype)
		local clients = {}
		for _, client in pairs(buf_clients) do
			if client.name ~= "copilot" then
				if client.config.filetypes ~= nil then
					if vim.tbl_contains(client.config.filetypes, filetype) then
						table.insert(clients, client.name)
					end
				end
			end
		end
		return clients
	end
	local buf_client_names = add_client(buf_ft)

	local conform_ok, conform = pcall(require, "conform")
	if conform_ok then
		local formatters = conform.list_formatters(0)
		for _, formatter in pairs(formatters) do
			table.insert(buf_client_names, formatter.name)
		end
	end

	-- RETURN CLIENTS
	if #buf_client_names > 3 then
		return "%#TeSTTLsp#" .. " " .. buf_client_names[1] .. ", " .. buf_client_names[2] .. ", " .. buf_client_names[3]
	end
	return "%#TeSTTLsp#" .. " " .. table.concat(vim.fn.uniq(buf_client_names), ", ")
end

return M
