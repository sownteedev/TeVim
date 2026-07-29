local M = {
	_offset = 1,
	_last_current = nil,
	_visible = {},
}

vim.cmd("function! TeBufGoToBuf(bufnr,b,c,d) \n execute 'b'..a:bufnr \n endfunction")
vim.cmd("function! ToggleTheme(a,b,c,d) \n TeVimThemes \n endfunction")
vim.cmd("function! ToggleTrans(a,b,c,d) \n TeVimToggleTrans \n endfunction")
vim.cmd("function! Split(a,b,c,d) \n vsplit \n endfunction")
vim.cmd("function! Run(a,b,c,d) \n lua require('tevim.core.utils').build_run() \n endfunction")
vim.cmd("function! Quit(a,b,c,d) \n qa! \n endfunction")
vim.cmd("function! TeBufScrollLeft(a,b,c,d) \n lua require('tevim.ui.tebufline').scroll(-1) \n endfunction")
vim.cmd("function! TeBufScrollRight(a,b,c,d) \n lua require('tevim.ui.tebufline').scroll(1) \n endfunction")
vim.cmd([[
	function! TeBufKillBuf(bufnr,b,c,d)
		call luaeval('require("tevim.ui.tebufline").close_buffer(_A)', a:bufnr)
	endfunction
]])

local devicons_present, devicons = pcall(require, "nvim-web-devicons")
local excluded_filetypes = { "neo-tree", "help", "dasher", "lir", "alpha", "toggleterm", "dashboard" }

local function new_hl(foreground_group, background_group)
	local fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(foreground_group)), "fg#")
	local bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(background_group)), "bg#")
	local name = "TeBuf" .. foreground_group .. background_group
	vim.api.nvim_set_hl(0, name, { fg = fg, bg = bg })
	return "%#" .. name .. "#"
end

local function truncate(text, limit)
	if vim.fn.strdisplaywidth(text) <= limit then
		return text
	end
	local result = ""
	for index = 0, vim.fn.strchars(text) - 1 do
		local char = vim.fn.strcharpart(text, index, 1)
		if vim.fn.strdisplaywidth(result .. char .. "…") > limit then
			break
		end
		result = result .. char
	end
	return result .. "…"
end

local function listed_buffers()
	local buffers = {}
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local name = vim.api.nvim_buf_get_name(buf)
		if
			vim.api.nvim_buf_is_valid(buf)
			and vim.api.nvim_buf_is_loaded(buf)
			and vim.bo[buf].buflisted
			and name ~= ""
			and not vim.tbl_contains(excluded_filetypes, vim.bo[buf].filetype)
		then
			buffers[#buffers + 1] = buf
		end
	end
	return buffers
end

local function display_name(buf, buffers)
	local path = vim.api.nvim_buf_get_name(buf)
	local basename = vim.fn.fnamemodify(path, ":t")
	for _, other in ipairs(buffers) do
		if other ~= buf and vim.fn.fnamemodify(vim.api.nvim_buf_get_name(other), ":t") == basename then
			return vim.fn.fnamemodify(path, ":h:t") .. "/", basename
		end
	end
	return "", basename
end

local function create_tab(buf, buffers, name_limit)
	local active = buf == vim.api.nvim_get_current_buf()
	local tab_group = active and "TeBufOnActive" or "TeBufOnInactive"
	local folder_group = active and "TeBufFolderOnActive" or "TeBufFolderOnInactive"
	local close_group = active and "TeBufOnClose" or "TeBufOffClose"
	local modified_group = active and "TeBufOnModified" or "TeBufOffModified"
	local folder, basename = display_name(buf, buffers)
	local plain_name = truncate(folder .. basename, name_limit)
	local shown_folder, shown_basename = "", plain_name

	if folder ~= "" and plain_name:sub(1, #folder) == folder then
		shown_folder = folder
		shown_basename = plain_name:sub(#folder + 1)
	end

	local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
	local icon, icon_hl
	if devicons_present then
		icon, icon_hl = devicons.get_icon(filename)
	end
	icon = icon or "󰈚"
	icon_hl = icon_hl or "DevIconDefault"

	local marker = vim.bo[buf].modified and "●" or "󰅖"
	local marker_group = vim.bo[buf].modified and modified_group or close_group
	local rendered = "%"
		.. buf
		.. "@TeBufGoToBuf@"
		.. "%#"
		.. tab_group
		.. "#  "
		.. new_hl(icon_hl, tab_group)
		.. icon
		.. "  "
		.. (shown_folder ~= "" and ("%#" .. folder_group .. "#" .. shown_folder) or "")
		.. "%#"
		.. tab_group
		.. "#"
		.. shown_basename
		.. "  %X%"
		.. buf
		.. "@TeBufKillBuf@%#"
		.. marker_group
		.. "#"
		.. marker
		.. "  %X%#TeBufEmptyColor#"
	local width = 2
		+ vim.fn.strdisplaywidth(icon)
		+ 2
		+ vim.fn.strdisplaywidth(plain_name)
		+ 2
		+ vim.fn.strdisplaywidth(marker)
		+ 2
	return rendered, width
end

local function tree_width()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "neo-tree" then
			return vim.api.nvim_win_get_width(win)
		end
	end
	return 0
end

local function click(handler, highlight, text)
	return "%@" .. handler .. "@%#" .. highlight .. "#" .. text .. "%X", vim.fn.strdisplaywidth(text)
end

local function controls()
	local parts, width = {}, 0
	local function add(handler, highlight, text)
		local rendered, item_width = click(handler, highlight, text)
		parts[#parts + 1] = rendered
		width = width + item_width
	end

	local runnable = {
		c = true,
		cpp = true,
		lua = true,
		python = true,
		rust = true,
		javascript = true,
		typescript = true,
		go = true,
		php = true,
		java = true,
		cs = true,
		dart = true,
		sh = true,
	}
	if vim.bo.filetype == "html" or vim.bo.filetype == "markdown" then
		add("Run", "TeBufRun", " 󰀂 ")
	elseif runnable[vim.bo.filetype] then
		add("Run", "TeBufRun", "  ")
	end
	add("Split", "TeBufSplit", "  ")
	add("ToggleTrans", "TeBufTrans", " 󱡓 ")
	add("ToggleTheme", "TeBufTheme", "   ")
	add("Quit", "TeBufQuit", " 󰅙 ")
	return table.concat(parts), width
end

local function current_index(buffers)
	local current = vim.api.nvim_get_current_buf()
	for index, buf in ipairs(buffers) do
		if buf == current then
			return index
		end
	end
	return 1
end

local function visible_tabs(buffers, available)
	local current = vim.api.nvim_get_current_buf()
	if M._last_current ~= current then
		M._last_current = current
		M._offset = current_index(buffers)
	end
	M._offset = math.max(1, math.min(M._offset, #buffers))

	local arrow_width = 3
	local name_limit = 24
	local tabs, total_width = {}, 0
	for _, buf in ipairs(buffers) do
		local rendered, width = create_tab(buf, buffers, name_limit)
		tabs[#tabs + 1] = { buf = buf, rendered = rendered, width = width }
		total_width = total_width + width
	end

	if total_width <= available then
		M._offset = 1
		M._visible = vim.deepcopy(buffers)
		return table.concat(vim.tbl_map(function(tab)
			return tab.rendered
		end, tabs)), false, false
	end

	local tab_space = math.max(1, available - arrow_width * 2)
	name_limit = math.max(3, math.min(name_limit, tab_space - 11))
	tabs = {}
	for _, buf in ipairs(buffers) do
		local rendered, width = create_tab(buf, buffers, name_limit)
		tabs[#tabs + 1] = { buf = buf, rendered = rendered, width = width }
	end

	local rendered, visible, used = {}, {}, 0
	local last = M._offset - 1
	for index = M._offset, #tabs do
		local tab = tabs[index]
		if used > 0 and used + tab.width > tab_space then
			break
		end
		if used == 0 or used + tab.width <= tab_space then
			rendered[#rendered + 1] = tab.rendered
			visible[#visible + 1] = tab.buf
			used = used + tab.width
			last = index
		end
	end

	M._visible = visible
	return table.concat(rendered), M._offset > 1, last < #tabs
end

local function scroll_button(direction, enabled)
	local handler = direction < 0 and "TeBufScrollLeft" or "TeBufScrollRight"
	local icon = direction < 0 and " 󰁍 " or " 󰁔 "
	local highlight = enabled and "TeBufScroll" or "TeBufScrollDisabled"
	return (click(handler, highlight, icon))
end

function M.scroll(direction)
	local buffers = listed_buffers()
	if #buffers == 0 then
		return
	end
	M._offset = math.max(1, math.min(#buffers, M._offset + direction))
	vim.cmd.redrawtabline()
end

function M.getTabline()
	local buffers = listed_buffers()
	local sidebar_width = tree_width()
	local treespace = "%#TeBufTree#" .. string.rep(" ", sidebar_width)
	local actions, actions_width = controls()
	local available = math.max(0, vim.o.columns - sidebar_width - actions_width)

	if #buffers < 2 or available < 12 then
		M._visible = {}
		return treespace .. "%#TeBufEmpty#%=" .. actions
	end

	local tabs, can_left, can_right = visible_tabs(buffers, available)
	local scrolling = can_left or can_right or M._offset > 1
	local left = scrolling and scroll_button(-1, can_left) or ""
	local right = scrolling and scroll_button(1, can_right) or ""
	return treespace .. left .. tabs .. right .. "%#TeBufEmpty#%=" .. actions
end

local function previous_buffer()
	local buffers = listed_buffers()
	for index, buf in ipairs(buffers) do
		if vim.api.nvim_get_current_buf() == buf then
			vim.cmd("buffer " .. (index == 1 and buffers[#buffers] or buffers[index - 1]))
			return
		end
	end
end

local function next_buffer()
	local buffers = listed_buffers()
	for index, buf in ipairs(buffers) do
		if vim.api.nvim_get_current_buf() == buf then
			vim.cmd("buffer " .. (index == #buffers and buffers[1] or buffers[index + 1]))
			return
		end
	end
end

function M.close_buffer(bufnr)
	if vim.bo.buftype == "terminal" then
		vim.cmd(vim.bo.buflisted and "set nobl | enew" or "hide")
		return
	end
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	if bufnr == vim.api.nvim_get_current_buf() then
		previous_buffer()
	end
	vim.cmd("confirm bdelete " .. bufnr)
end

local function close_other_buffers()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(listed_buffers()) do
		if buf ~= current then
			vim.cmd("confirm bdelete " .. buf)
		end
	end
	vim.cmd.redrawtabline()
end

function M.setup()
	for name, callback in pairs({
		TeBufPrev = previous_buffer,
		TeBufNext = next_buffer,
		TeBufCloseOtherBuf = close_other_buffers,
		TeBufKillBuf = function()
			M.close_buffer(vim.api.nvim_get_current_buf())
		end,
	}) do
		pcall(vim.api.nvim_del_user_command, name)
		vim.api.nvim_create_user_command(name, callback, {})
	end

	vim.o.showtabline = 2
	vim.o.tabline = '%!v:lua.require("tevim.ui.tebufline").getTabline()'
	vim.keymap.set("n", "<Tab>", next_buffer, { silent = true, desc = "Next buffer" })
	vim.keymap.set("n", "<S-Tab>", previous_buffer, { silent = true, desc = "Previous buffer" })
	vim.keymap.set("n", "<C-o>", close_other_buffers, { silent = true, desc = "Close other buffers" })
	vim.keymap.set("n", "<C-q>", function()
		M.close_buffer(vim.api.nvim_get_current_buf())
	end, { silent = true, desc = "Close buffer" })
end

return M
