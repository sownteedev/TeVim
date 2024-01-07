local M = function()
	--- @diagnostic disable warnings
	local buf_clients = vim.lsp.get_active_clients()
	if not buf_clients then
		return ""
	end
	local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
	if next(buf_clients) == nil then
		return ""
	end
	local null_ls = require("null-ls")
	local alternative_methods = {
		null_ls.methods.DIAGNOSTICS,
		null_ls.methods.DIAGNOSTICS_ON_OPEN,
		null_ls.methods.DIAGNOSTICS_ON_SAVE,
	}

	-- ADD CLIENTS
	local add_client = function(filetype)
		local clients = {}
		for _, client in pairs(buf_clients) do
			if client.name ~= "null-ls" and client.name ~= "copilot" then
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

	-- ADD FORMATERS AND LINTERS
	local list_registered_providers_names = function(filetype)
		local s = require("null-ls.sources")
		local available_sources = s.get_available(filetype)
		local registered = {}
		for _, source in ipairs(available_sources) do
			for method in pairs(source.methods) do
				registered[method] = registered[method] or {}
				table.insert(registered[method], source.name)
			end
		end
		return registered
	end

	-- formatters
	local formatters_list_registered = function(filetype)
		local registered_providers = list_registered_providers_names(filetype)
		return registered_providers[null_ls.methods.FORMATTING] or {}
	end
	local supported_formatters = formatters_list_registered(buf_ft)
	vim.list_extend(buf_client_names, supported_formatters)

	-- linters
	local linters_list_registered = function(filetype)
		local registered_providers = list_registered_providers_names(filetype)
		local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
			return registered_providers[m] or {}
		end, alternative_methods))
		return providers_for_methods
	end
	local supported_linters = linters_list_registered(buf_ft)
	vim.list_extend(buf_client_names, supported_linters)

	-- RETURN CLIENTS
	if #buf_client_names > 3 then
		return "%#TeSTTLsp#" ..
			" " .. buf_client_names[1] .. ", " .. buf_client_names[2] .. ", " .. buf_client_names[3] .. " "
	end
	return "%#TeSTTLsp#" .. " " .. table.concat(vim.fn.uniq(buf_client_names), ", ") .. " "
end

return M
