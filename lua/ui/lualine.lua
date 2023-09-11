local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

-- Require theme color you're using
local colors = require('themes.schemes.yoru').get_colors()

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", hint = " ", info = " " },
	colored = true,
	padding = { left = 1, right = 1 },
	always_visible = false,
	update_in_insert = true,
	color = { bg = colors.black2 }
}

local branch = {
	"branch",
	icon = "",
	color = { fg = colors.dark_purple, bg = colors.black2 },
	padding = { left = -2 },
}

local diff = {
	"diff",
	colored = true,
	color = { added = 'DiffAdd', modified = 'DiffChange', removed = 'DiffDelete', bg = colors.black2 },
	symbols = { added = " ", modified = " ", removed = " " },
	padding = { left = 1, right = 1 },
}

local result = vim.fn.system("git rev-parse --is-inside-work-tree")
local gitcheck = function()
	if result:match("true") then
		return ""
	else
		return " 󱓌 "
	end
end

local gitchecks = function()
	if result:match("true") then
		return ""
	else
		return ""
	end
end

local lsp_progess = function()
	local buf_clients = vim.lsp.get_active_clients()
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
		return buf_client_names[1] .. ", " .. buf_client_names[2] .. ", " .. buf_client_names[3]
	end
	return table.concat(vim.fn.uniq(buf_client_names), ", ")
end

local copilot = function()
	local copilot_active = false
	local buf_clients = vim.lsp.get_active_clients()
	for _, client in pairs(buf_clients) do
		if client.name == "copilot" then
			copilot_active = true
		end
	end
	if copilot_active == true then
		return " "
	elseif copilot_active == false then
		return " "
	end
end

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {
			{
				function()
					return ""
				end,
				separator = { left = "█", right = "█" },
			},
		},
		lualine_b = {
			{
				function()
					return " "
				end
			},
			{
				"filetype",
				icon_only = true,
				colored = true,
				padding = { left = 2, right = 2 },
				color = { bg = colors.red },
			},
			{
				"filename",
				padding = { left = -1 },
				separator = { left = "█", right = "█" },
				color = { bg = colors.black2, fg = colors.red, gui = "bold,italic" },
				file_status = true,
				newfile_status = true,
				path = 5,
				symbols = {
					modified = "",
					readonly = "",
					unnamed = "",
					newfile = "",
				},
			},
		},
		lualine_c = {
			{
				function()
					return " "
				end
			},
			{
				function()
					return ""
				end,
				color = { bg = colors.purple, fg = colors.black },
			},
			{
				gitcheck,
				color = { fg = colors.purple },
			},
			branch,
			{
				function()
					return " "
				end
			},
			diff,
			{
				gitchecks,
				separator = { left = "█", right = "█" },
				color = { bg = colors.blue, fg = colors.black },
			}
		},
		lualine_x = {
			{
				function()
					return " "
				end,
				separator = { left = "█", right = "█" },
				color = { bg = colors.orange, fg = colors.black },
			},
			diagnostics,
			{
				lsp_progess,
				color = { fg = colors.orange, bg = colors.black2 },

			},
			{
				copilot,
				color = { fg = colors.vibrant_green, bg = colors.black2 },
			},
			{
				function()
					return " "
				end
			},
			{
				function()
					return ""
				end,
				separator = { left = "█", right = "█" },
				color = { bg = colors.blue, fg = colors.black },
			},
			{
				function()
					return "" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
				end,
				color = { fg = colors.blue, bg = colors.black2 },
			},
			{
				function()
					return " "
				end
			},
			{
				function()
					return ""
				end,
				separator = { left = "█", right = "█" },
				color = { bg = colors.pink, fg = colors.black },
			},
			{
				"progress",
				color = { bg = colors.black2, fg = colors.pink },
			},
			{
				function()
					return " "
				end
			},
			{
				function()
					return ""
				end,
				separator = { left = "█", right = "█" },
				color = { bg = colors.yellow, fg = colors.black },
			},
			{
				"location",
				padding = 1,
				color = { fg = colors.yellow, bg = colors.black2 }
			},
			-- {
			-- 	function()
			-- 		local current_line = vim.fn.line(".")
			-- 		local total_lines = vim.fn.line("$")
			-- 		local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
			-- 		local progress_percent = current_line / total_lines
			-- 		local index = math.ceil(progress_percent * #chars)
			-- 		return chars[index]
			-- 	end,
			-- 	color = { fg = colors.orange },
			-- }
		},
		lualine_y = {},
		lualine_z = {},
	},
})
