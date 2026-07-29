local is_available = require("tevim.core.utils").is_available
local M = {}

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
local mode = function()
	local current_mode = vim.api.nvim_get_mode().mode
	local mode_info = modes[current_mode] or modes.n
	local mode_icon = icon[current_mode] or icon.n
	return "%#"
		.. mode_icon[2]
		.. "#"
		.. mode_icon[1]
		.. " "
		.. "%#"
		.. mode_info[2]
		.. "#"
		.. " "
		.. mode_info[1]
		.. " "
end

local function truncate(text, limit)
	if vim.fn.strdisplaywidth(text) <= limit then
		return text
	end
	local result = ""
	for index = 0, vim.fn.strchars(text) - 1 do
		local character = vim.fn.strcharpart(text, index, 1)
		if vim.fn.strdisplaywidth(result .. character .. "…") > limit then
			break
		end
		result = result .. character
	end
	return result .. "…"
end

local filename = function(limit, show_project)
	---@diagnostic disable-next-line: redefined-local
	local icon = " 󰢚 "
	local filename = (vim.fn.expand("%") == "" and "Empty ") or vim.fn.expand("%:t")
	if filename ~= "Empty " then
		local devicons = require("nvim-web-devicons")
		local ft_icon = devicons.get_icon(filename)
		icon = (ft_icon ~= nil and " " .. ft_icon) or ""
		if string.find(filename, "filesystem") then
			filename = "File Explorer"
			return "%#TeSTTFileIcon#" .. " 󰝰 " .. "%#TeSTTFileName#" .. " " .. filename .. " "
		end
		if string.find(filename, "toggleterm") then
			filename = "Terminal"
			return "%#TeSTTFileIcon#" .. "  " .. "%#TeSTTFileName#" .. " " .. filename .. " "
		end
		filename = truncate(filename, limit or 32)
		local project = show_project and (truncate(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"), 14) .. "/") or ""
		return "%#TeSTTFileIcon#"
			.. icon
			.. " "
			.. "%#TeSTTFolder#"
			.. (project ~= "" and (" " .. project) or "")
			.. "%#TeSTTFileName#"
			.. filename
			.. " "
	else
		return "%#TeSTTFileIcon#" .. icon .. "%#TeSTTFileName# TEVIM "
	end
end

local branch = function(limit)
	if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
		return "%#TeSTTBranchIcon#" .. " 󱓌 "
	end

	local git_status = vim.b.gitsigns_status_dict
	local branch_name = truncate(git_status.head, limit or 20) .. " "

	return "%#TeSTTBranchIcon#" .. "  " .. "%#TeSTTBranchName#" .. " " .. branch_name
end

local diff = function()
	if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
		return ""
	end

	local git_status = vim.b.gitsigns_status_dict

	local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
	local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
	local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
	if (#added > 0) or (#changed > 0) or (#removed > 0) then
		return "%#TeSTTDiffAdd#"
			.. added
			.. "%#TeSTTDiffChange#"
			.. changed
			.. "%#TeSTTDiffRemove#"
			.. removed
			.. " "
			.. "%#TeSTTGithub#"
			.. " 󰊤 "
	else
		return ""
	end
end

local diagnostics = function(compact)
	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
	local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
	local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	local error_text = errors > 0 and ("%#TeSTTErrorIcon#  %#TeSTTError#" .. errors) or ""
	local warning_text = warnings > 0 and ("%#TeSTTWarningIcon#  %#TeSTTWarning#" .. warnings) or ""
	local hint_text = hints > 0 and ("%#TeSTTHintsIcon# 󰌶 %#TeSTTHints#" .. hints) or ""
	local info_text = info > 0 and ("%#TeSTTInfoIcon#  %#TeSTTInfo#" .. info) or ""
	if compact then
		return error_text .. warning_text .. " "
	end
	return error_text .. warning_text .. hint_text .. info_text
end

local lsp = function(max_clients)
	local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
	local buf_ft = vim.bo.filetype
	if next(buf_clients) == nil then
		return ""
	end

	-- ADD CLIENTS
	local add_client = function(filetype)
		local clients = {}
		for _, client in pairs(buf_clients) do
			if client.config.filetypes ~= nil then
				if vim.tbl_contains(client.config.filetypes, filetype) then
					table.insert(clients, client.name)
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
	buf_client_names = vim.fn.uniq(buf_client_names)
	max_clients = max_clients or 3
	local prefix = "%#TeSTTLspIcon# 󰒋 %#TeSTTLsp# "
	if #buf_client_names > max_clients then
		local visible = vim.list_slice(buf_client_names, 1, max_clients)
		return prefix .. table.concat(visible, ", ") .. " +" .. (#buf_client_names - max_clients) .. " "
	end
	return prefix .. table.concat(buf_client_names, ", ") .. " "
end

local copilot = function()
	if not is_available("copilot.vim") and not is_available("copilot.lua") then
		return ""
	end
	for _, client in pairs(vim.lsp.get_clients()) do
		if client.name == "GitHub Copilot" then
			return "%#TeSTTCopilot#" .. "  "
		end
	end
	return "%#TeSTTCopilot#" .. "   "
end

local codeium = function()
	if is_available("codeium.nvim") then
		return "%#TeSTTCodeium#" .. "  "
	end
	return ""
end

local tabnine = function()
	if not is_available("tabnine-nvim") then
		return ""
	end
	local tabnine = require("tabnine.status").status()
	if tabnine == "⌬ tabnine starter" then
		return "%#TeSTTTabnine#" .. "⌬ "
	end
	return ""
end

local tab = function()
	return "%#TeSTTTabIcon#" .. "  " .. "%#TeSTTTab#" .. " " .. vim.bo.shiftwidth .. " "
end

local location = function()
	return "%#TeSTTLocationIcon#"
		.. "  "
		.. "%#TeSTTLocation#"
		.. string.format(" %3d:%-2d ", vim.fn.line("."), vim.fn.virtcol("."))
end

local progress = function()
	local current_line = math.max(1, vim.fn.line("."))
	local total_lines = math.max(1, vim.fn.line("$"))
	local chars = { "  ", " 󰪞 ", " 󰪟 ", " 󰪠 ", " 󰪢 ", " 󰪣 ", " 󰪤 ", " 󰪥 " }
	local progress_percent = current_line / total_lines
	local index = math.max(1, math.min(#chars, math.ceil(progress_percent * #chars)))
	if current_line == 1 then
		return "%#TeSTTProgressIcon#" .. chars[index] .. "%#TeSTTProgress#" .. " Top "
	elseif current_line == total_lines then
		return "%#TeSTTProgressIcon#" .. chars[index] .. "%#TeSTTProgress#" .. " Bot "
	else
		return "%#TeSTTProgressIcon#"
			.. chars[index]
			.. "%#TeSTTProgress#"
			.. string.format(" %2d%%%% ", math.floor(current_line / total_lines * 100))
	end
end

local countBuffer = function()
	local counter = 0
	for _, buf in pairs(vim.api.nvim_list_bufs()) do
		local filenames = vim.api.nvim_buf_get_name(buf):match("^.+/(.+)$") or ""
		if
			vim.api.nvim_buf_is_valid(buf)
			and vim.api.nvim_buf_is_loaded(buf)
			and vim.bo[buf].buflisted
			and filenames ~= ""
		then
			counter = counter + 1
		end
	end
	return counter
end

local nothing = function()
	if countBuffer() < 2 then
		return "%#TeSTTNothing2#" .. "    "
	end
	return "%#TeSTTNothing#" .. "    "
end

local function right_side(components)
	local visible = {}
	for _, component in ipairs(components) do
		if component and component ~= "" and component ~= " " then
			visible[#visible + 1] = component
		end
	end
	return table.concat(visible, "%#TeSTTNothing2#  ")
end

function M.run(forced_width)
	local width = forced_width or (vim.o.laststatus == 3 and vim.o.columns or vim.api.nvim_win_get_width(0))
	local gap = nothing()
	local align = "%#TeSTTNothing2#%="

	if vim.bo.filetype == "neo-tree" then
		return table.concat({
			mode(),
			"%#TeSTTNothing2#  ",
			"%#TeSTTFileIcon# 󰝰 ",
			"%#TeSTTFileName# Explorer ",
			align,
		})
	end

	if width < 52 then
		return table.concat({
			mode(),
			align,
			location(),
		})
	elseif width < 72 then
		return table.concat({
			mode(),
			align,
			right_side({ diagnostics(true), location() }),
		})
	elseif width < 96 then
		return table.concat({
			mode(),
			gap,
			filename(14, true),
			align,
			right_side({ diagnostics(true), progress(), location() }),
		})
	elseif width < 120 then
		return table.concat({
			mode(),
			gap,
			filename(20, true),
			gap,
			branch(12),
			align,
			right_side({ diagnostics(true), tab(), progress(), location() }),
		})
	elseif width < 150 then
		return table.concat({
			mode(),
			gap,
			filename(28, true),
			gap,
			branch(16),
			align,
			right_side({ diagnostics(false), lsp(1), tab(), progress(), location() }),
		})
	end

	return table.concat({
		mode(),
		gap,
		filename(36, true),
		gap,
		branch(),
		gap,
		diff(),
		align,
		right_side({
			diagnostics(false),
			lsp(3),
			copilot(),
			codeium(),
			tabnine(),
			tab(),
			progress(),
			location(),
		}),
	})
end

function M.setup()
	vim.opt.laststatus = 3
	vim.o.statusline = "%!v:lua.require('tevim.ui.testatusline').run()"
	local group = vim.api.nvim_create_augroup("tevim_statusline", { clear = true })
	vim.api.nvim_create_autocmd({ "ModeChanged", "DiagnosticChanged", "LspAttach", "LspDetach", "VimResized" }, {
		group = group,
		callback = vim.schedule_wrap(function()
			vim.cmd.redrawstatus()
		end),
	})
end

return M
