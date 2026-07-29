local M = {}

local logo = {
	"▄███████▓▓████▓ ██▒   █▓ ██▓ ███▄ ▄███▓ ",
	"▓  ██▒ ▓▒▓█   ▀▓██░   █▒▓██▒▓██▒▀█▀ ██▒ ",
	"▒ ▓██░ ▒░▒███   ▓██  █▒░▒██▒▓██    ▓██░ ",
	"░ ▓██▓ ░ ▒▓█  ▄  ▒██ █░░░██░▒██    ▒██  ",
	"  ▒██▒ ░ ░▒████▒  ▒▀█░  ░██░▒██▒   ░██▒ ",
	"  ▒ ░░   ░░ ▒░ ░  ░ ▐░  ░▓  ░ ▒░   ░  ░ ",
	"    ░     ░ ░  ░  ░ ░░   ▒ ░░  ░      ░ ",
	"  ░         ░        ░   ▒ ░       ░    ",
}

local buttons = {
	{ "  Find File", "󱁐 f f", "Telescope find_files" },
	{ "󰈚  TODO List", "󱁐 f t", "TodoTelescope" },
	{ "  TeVim Themes", "󱁐 f c", "TeVimThemes" },
	{ "󰒲  Lazy", "󱁐 p S", "Lazy show" },
	{ "  Quit", "󱁐 q", "q" },
}

local api = vim.api
local fn = vim.fn

local loadTeDash = vim.g.loadTeDash

local headerAscii = logo
local emmptyLine = string.rep(" ", vim.fn.strwidth(headerAscii[1]))

table.insert(headerAscii, 1, emmptyLine)
table.insert(headerAscii, 2, emmptyLine)

headerAscii[#headerAscii + 1] = emmptyLine
headerAscii[#headerAscii + 1] = emmptyLine

local tedashWidth = #headerAscii[1] + 3

local max_height = #headerAscii + 4 + (2 * #buttons)
local get_win_height = api.nvim_win_get_height

M.setup = function(target_win)
	if vim.g.loadTeBufLine then
		vim.o.tabline = '%!v:lua.require("tevim.ui.tebufline").getTabline()'
	end
	if loadTeDash then
		if not target_win and vim.bo.filetype ~= "tedash" then
			vim.g.nv_previous_buf = vim.api.nvim_get_current_buf()
		end

		local buf = vim.api.nvim_create_buf(false, true)
		local win = target_win
		if not win or not api.nvim_win_is_valid(win) then
			win = api.nvim_get_current_win()
			for _, candidate in ipairs(api.nvim_tabpage_list_wins(0)) do
				local candidate_buf = api.nvim_win_get_buf(candidate)
				if
					vim.bo[candidate_buf].filetype ~= "neo-tree"
					and api.nvim_win_get_width(candidate) > api.nvim_win_get_width(win)
				then
					win = candidate
				end
			end
		end

		local win_width = api.nvim_win_get_width(win)

		api.nvim_win_set_buf(win, buf)

		vim.bo[buf].filetype = "tedash"
		vim.g.tedash_displayed = true

		local header = headerAscii
		local buttonsS = buttons

		local function addSpacing_toBtns(txt1, txt2)
			local btn_len = fn.strwidth(txt1) + fn.strwidth(txt2)
			local spacing = fn.strwidth(header[1]) - btn_len
			return txt1 .. string.rep(" ", spacing - 1) .. txt2 .. " "
		end

		local function addPadding_toHeader(str)
			local pad = math.max(0, math.floor((win_width - fn.strwidth(str)) / 2))
			return string.rep(" ", pad) .. str .. " "
		end

		local dashboard = {}

		for _, val in ipairs(header) do
			table.insert(dashboard, val .. " ")
		end

		for _, val in ipairs(buttonsS) do
			table.insert(dashboard, addSpacing_toBtns(val[1], val[2]) .. " ")
			table.insert(dashboard, header[1] .. " ")
		end

		local result = {}

		for i = 1, math.max(get_win_height(win), max_height) do
			result[i] = ""
		end

		local vertical_padding = math.max(0, math.floor((get_win_height(win) - #dashboard) / 2))
		local headerStart_Index = vertical_padding + 1
		local abc = vertical_padding + 1

		-- set ascii
		for _, val in ipairs(dashboard) do
			result[headerStart_Index] = addPadding_toHeader(val)
			headerStart_Index = headerStart_Index + 1
		end

		api.nvim_buf_set_lines(buf, 0, -1, false, result)

		local tedash = api.nvim_create_namespace("tedash")
		local horiz_pad_index = math.max(0, math.floor((win_width - tedashWidth) / 2) - 2)

		for i = abc, abc + #header do
			api.nvim_buf_add_highlight(buf, tedash, "TeDashAscii", i, horiz_pad_index, -1)
		end

		for i = abc + #header - 2, abc + #dashboard do
			api.nvim_buf_add_highlight(buf, tedash, "TeDashButtons", i, horiz_pad_index, -1)
		end

		local cursor_column = math.max(0, math.floor((win_width - tedashWidth) / 2) + 1)
		api.nvim_win_set_cursor(win, { abc + #header, cursor_column })

		local first_btn_line = abc + #header + 2
		local keybind_lineNrs = {}

		for _, _ in ipairs(buttons) do
			table.insert(keybind_lineNrs, first_btn_line - 2)
			first_btn_line = first_btn_line + 2
		end

		vim.keymap.set("n", "h", "", { buffer = buf })
		vim.keymap.set("n", "<Left>", "", { buffer = buf })
		vim.keymap.set("n", "l", "", { buffer = buf })
		vim.keymap.set("n", "<Right>", "", { buffer = buf })

		vim.keymap.set("n", "k", function()
			local cur = fn.line(".")
			local target_line = cur == keybind_lineNrs[1] and keybind_lineNrs[#keybind_lineNrs] or cur - 2
			api.nvim_win_set_cursor(win, { target_line, cursor_column })
		end, { buffer = buf })

		vim.keymap.set("n", "j", function()
			local cur = fn.line(".")
			local target_line = cur == keybind_lineNrs[#keybind_lineNrs] and keybind_lineNrs[1] or cur + 2
			api.nvim_win_set_cursor(win, { target_line, cursor_column })
		end, { buffer = buf })

		vim.keymap.set("n", "<Up>", function()
			local cur = fn.line(".")
			local target_line = cur == keybind_lineNrs[1] and keybind_lineNrs[#keybind_lineNrs] or cur - 2
			api.nvim_win_set_cursor(win, { target_line, cursor_column })
		end, { buffer = buf })

		vim.keymap.set("n", "<Down>", function()
			local cur = fn.line(".")
			local target_line = cur == keybind_lineNrs[#keybind_lineNrs] and keybind_lineNrs[1] or cur + 2
			api.nvim_win_set_cursor(win, { target_line, cursor_column })
		end, { buffer = buf })

		vim.keymap.set("n", "<CR>", function()
			for i, val in ipairs(keybind_lineNrs) do
				if val == fn.line(".") then
					local action = buttons[i][3]
					if type(action) == "string" then
						vim.cmd(action)
					elseif type(action) == "function" then
						action()
					end
				end
			end
		end, { buffer = buf })

		vim.bo[buf].buflisted = false
		vim.bo[buf].modifiable = false
		vim.wo[win].number = false
		vim.wo[win].list = false
		vim.wo[win].relativenumber = false
		vim.wo[win].wrap = false
		vim.wo[win].cursorline = false
		vim.wo[win].foldcolumn = "0"
		vim.wo[win].statuscolumn = ""
		vim.wo[win].colorcolumn = ""
		vim.o.showtabline = 0
	elseif vim.g.loadTeBufLine then
		vim.o.showtabline = 2
		vim.o.tabline = '%!v:lua.require("tevim.ui.tebufline").getTabline()'
	end
end

if loadTeDash then
	pcall(api.nvim_del_user_command, "TeDash")
	api.nvim_create_user_command("TeDash", function()
		if vim.g.tedash_displayed then
			local previous = vim.g.nv_previous_buf
			if previous and api.nvim_buf_is_valid(previous) then
				api.nvim_win_set_buf(0, previous)
			else
				api.nvim_win_set_buf(0, api.nvim_create_buf(true, false))
			end
			vim.g.tedash_displayed = false
			if vim.g.loadTeBufLine then
				vim.o.showtabline = 2
			end
		else
			M.setup()
		end
	end, {})

	local group = api.nvim_create_augroup("tevim_dashboard", { clear = true })
	api.nvim_create_autocmd("VimResized", {
		group = group,
		callback = function()
			for _, win in ipairs(api.nvim_tabpage_list_wins(0)) do
				if vim.bo[api.nvim_win_get_buf(win)].filetype == "tedash" then
					require("tevim.ui.tedash").setup(win)
				end
			end
		end,
		desc = "Resize Dashboard",
	})

	api.nvim_create_autocmd("BufLeave", {
		group = group,
		callback = function()
			if vim.bo.ft == "tedash" then
				vim.g.tedash_displayed = false
				if vim.g.loadTeBufLine then
					vim.o.showtabline = 2
				end
			end
		end,
	})
end

return M
