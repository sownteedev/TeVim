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

M.setup = function()
	if loadTeDash then
		vim.g.nv_previous_buf = vim.api.nvim_get_current_buf()

		local buf = vim.api.nvim_create_buf(false, true)
		local win = api.nvim_get_current_win()

		if tedashWidth + 6 > api.nvim_win_get_width(0) then
			vim.api.nvim_set_current_win(api.nvim_list_wins()[2])
			win = api.nvim_get_current_win()
		end

		api.nvim_win_set_buf(win, buf)

		vim.opt_local.filetype = "tedash"
		vim.g.tedash_displayed = true

		local header = headerAscii
		local buttonsS = buttons

		local function addSpacing_toBtns(txt1, txt2)
			local btn_len = fn.strwidth(txt1) + fn.strwidth(txt2)
			local spacing = fn.strwidth(header[1]) - btn_len
			return txt1 .. string.rep(" ", spacing - 1) .. txt2 .. " "
		end

		local function addPadding_toHeader(str)
			local pad = (api.nvim_win_get_width(win) - fn.strwidth(str)) / 2
			return string.rep(" ", math.floor(pad)) .. str .. " "
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

		local headerStart_Index = math.abs(math.floor((get_win_height(win) / 2) - (#dashboard / 2))) + 1
		local abc = math.abs(math.floor((get_win_height(win) / 2) - (#dashboard / 2))) + 1

		-- set ascii
		for _, val in ipairs(dashboard) do
			result[headerStart_Index] = addPadding_toHeader(val)
			headerStart_Index = headerStart_Index + 1
		end

		api.nvim_buf_set_lines(buf, 0, -1, false, result)

		local tedash = api.nvim_create_namespace("tedash")
		local horiz_pad_index = math.floor((api.nvim_win_get_width(win) / 2) - (tedashWidth / 2)) - 2

		for i = abc, abc + #header do
			api.nvim_buf_add_highlight(buf, tedash, "TeDashAscii", i, horiz_pad_index, -1)
		end

		for i = abc + #header - 2, abc + #dashboard do
			api.nvim_buf_add_highlight(buf, tedash, "TeDashButtons", i, horiz_pad_index, -1)
		end

		api.nvim_win_set_cursor(win, { abc + #header, math.floor(vim.o.columns / 2) - 13 })

		local first_btn_line = abc + #header + 2
		local keybind_lineNrs = {}

		for _, _ in ipairs(buttons) do
			table.insert(keybind_lineNrs, first_btn_line - 2)
			first_btn_line = first_btn_line + 2
		end

		vim.keymap.set("n", "h", "", { buffer = true })
		vim.keymap.set("n", "<Left>", "", { buffer = true })
		vim.keymap.set("n", "l", "", { buffer = true })
		vim.keymap.set("n", "<Right>", "", { buffer = true })

		vim.keymap.set("n", "k", function()
			local cur = fn.line(".")
			local target_line = cur == keybind_lineNrs[1] and keybind_lineNrs[#keybind_lineNrs] or cur - 2
			api.nvim_win_set_cursor(win, { target_line, math.floor(vim.o.columns / 2) - 13 })
		end, { buffer = true })

		vim.keymap.set("n", "j", function()
			local cur = fn.line(".")
			local target_line = cur == keybind_lineNrs[#keybind_lineNrs] and keybind_lineNrs[1] or cur + 2
			api.nvim_win_set_cursor(win, { target_line, math.floor(vim.o.columns / 2) - 13 })
		end, { buffer = true })

		vim.keymap.set("n", "<Up>", function()
			local cur = fn.line(".")
			local target_line = cur == keybind_lineNrs[1] and keybind_lineNrs[#keybind_lineNrs] or cur - 2
			api.nvim_win_set_cursor(win, { target_line, math.floor(vim.o.columns / 2) - 13 })
		end, { buffer = true })

		vim.keymap.set("n", "<Down>", function()
			local cur = fn.line(".")
			local target_line = cur == keybind_lineNrs[#keybind_lineNrs] and keybind_lineNrs[1] or cur + 2
			api.nvim_win_set_cursor(win, { target_line, math.floor(vim.o.columns / 2) - 13 })
		end, { buffer = true })

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
		end, { buffer = true })

		vim.opt_local.buflisted = false
		vim.opt_local.modifiable = false
		vim.opt_local.number = false
		vim.opt_local.list = false
		vim.opt_local.relativenumber = false
		vim.opt_local.wrap = false
		vim.opt_local.cul = false
		vim.opt_local.foldcolumn = "0"
		vim.opt_local.stc = ""
		vim.opt_local.colorcolumn = "0"
		vim.opt_local.showtabline = 0
	elseif vim.g.loadTeBufLine then
		vim.o.tabline = '%!v:lua.require("tevim.ui.tebufline").getTabline()'
	end
end

if loadTeDash then
	api.nvim_create_user_command("TeDash", function()
		if vim.g.tedash_displayed then
			require("tevim.ui.tebufline.modules").close_buffer()
		else
			M.setup()
		end
	end, {})

	api.nvim_create_autocmd("VimResized", {
		callback = function()
			if vim.bo.filetype == "tedash" or vim.bo.filetype == "neo-tree" then
				vim.opt_local.modifiable = true
				vim.api.nvim_buf_set_lines(0, 0, -1, false, { "" })
				require("tevim.ui.tedash").setup()
			end
		end,
		desc = "Resize Dashboard",
	})

	api.nvim_create_autocmd("BufLeave", {
		callback = function()
			if vim.bo.ft == "tedash" then
				vim.g.tedash_displayed = false
			end
		end,
	})
end

return M
