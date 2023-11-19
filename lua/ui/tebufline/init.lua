local M = {}

local devicons_present, devicons = pcall(require, "nvim-web-devicons")

-- Commands
vim.cmd "function! TeBufGoToBuf(bufnr,b,c,d) \n execute 'b'..a:bufnr \n endfunction"
vim.cmd "function! ToggleTheme(a,b,c,d) \n TeVimThemesToggle \n endfunction"
vim.cmd "function! Split(a,b,c,d) \n vsplit \n endfunction"
vim.cmd "function! Run(a,b,c,d) \n lua require('user.functions').build_run() \n endfunction"
vim.cmd "function! Quit(a,b,c,d) \n qa! \n endfunction"
vim.cmd [[
   function! TeBufKillBuf(bufnr,b,c,d)
        call luaeval('require("ui.tebufline.modules").close_buffer(_A)', a:bufnr)
  endfunction]]

vim.api.nvim_create_user_command("TeBufPrev", function()
	require("ui.tebufline.modules").tebuflinePrev()
end, {})
vim.api.nvim_create_user_command("TeBufNext", function()
	require("ui.tebufline.modules").tebuflineNext()
end, {})

-------------------------------------------------------------------------

local function new_hl(group1, group2)
	local fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group1)), "fg#")
	local bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group2)), "bg#")
	vim.api.nvim_set_hl(0, "TeBuf" .. group1 .. group2, { fg = fg, bg = bg })
	return "%#" .. "TeBuf" .. group1 .. group2 .. "#"
end

local createTab = function(buf)
	if devicons_present then
		local filename = (#vim.api.nvim_buf_get_name(buf) ~= 0) and
			vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t") or
			""
		local icon, icon_hl = devicons.get_icon(filename)
		if not icon then
			icon = "󰈚 "
			icon_hl = "DevIconDefault"
		end
		icon = (
			vim.api.nvim_get_current_buf() == buf and new_hl(icon_hl, "TeBufOnActive") .. " " .. icon
			or new_hl(icon_hl, "TeBufOnInactive") .. " " .. icon
		)
		local close_btn = "%" .. buf .. "@TeBufKillBuf@󰅖%X"
		for _, buffer in pairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_valid(buffer) and vim.api.nvim_buf_is_loaded(buffer) and vim.bo[buffer].buflisted and filename ~= "" then
				if filename == vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buffer), ":t") and buffer ~= buf then
					local other = {}
					for match in (vim.api.nvim_buf_get_name(buffer) .. "/"):gmatch("(.-)" .. "/") do
						table.insert(other, match)
					end

					local current = {}
					for match in (vim.api.nvim_buf_get_name(buf) .. "/"):gmatch("(.-)" .. "/") do
						table.insert(current, match)
					end

					filename = current[#current]

					for i = #current - 1, 1, -1 do
						local value_current = current[i]
						local other_current = other[i]

						if value_current ~= other_current then
							filename = value_current .. '/' .. filename
							break
						end
					end
					break
				end
			end
		end
		if buf == vim.api.nvim_get_current_buf() then
			filename = "%#TeBufOnActive#" .. "   " .. icon .. "%#TeBufOnActive#" .. "  " .. filename
			close_btn = (vim.bo[0].modified and "%" .. buf .. "@BufflineKillBuf@%#TeBufOnModified# ●   ")
				or ("%#TeBufOnClose#" .. close_btn) .. "   "
		else
			filename = "%#TeBufOnInactive#" .. "   " .. icon .. "%#TeBufOnInactive#" .. "  " .. filename
			close_btn = (vim.bo[buf].modified and "%" .. buf .. "@BufflineKillBuf@%#TeBufOffModified# ●   ")
				or ("%#TeBufOffClose#" .. close_btn) .. "   "
		end
		return "%" .. buf .. "@TeBufGoToBuf@" .. filename .. "  " .. close_btn .. '%X' .. "%#TeBufEmptyColor#"
	end
end

local excludedFileTypes = { 'neo-tree', 'help', 'dasher', 'lir', 'alpha', "toggleterm" }
local treeWidth = function()
	for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.bo[vim.api.nvim_win_get_buf(win)].ft == "neo-tree" then
			return vim.api.nvim_win_get_width(win)
		end
	end
	return 0
end
M.getTabline = function()
	local buffline = ""
	local buffstart = "%#TeBufEmpty#"
	local run = "%@Run@" .. "  "
	if vim.bo.filetype == "html" then
		run = "%@Run@" .. " 󰀂 "
	end
	local theme = "%@ToggleTheme@" .. "   "
	local split = "%@Split@" .. "  "
	local quit = "%@Quit@" .. " 󰅜 "
	local counter = 0
	for _, buf in pairs(vim.api.nvim_list_bufs()) do
		local filename = vim.api.nvim_buf_get_name(buf):match("^.+/(.+)$") or ""
		if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and filename ~= "" then
			local conditions = vim.tbl_contains(excludedFileTypes, vim.bo[buf].ft)
			if conditions then goto do_nothing else filename = "%#TeBufEmptyColor#" .. createTab(buf) end
			buffline = buffline .. filename
			counter = counter + 1
		end
		::do_nothing::
	end
	local treespace
	if treeWidth() > 2 then
		treespace = "%#TeBufTree#" ..
			string.rep(" ", treeWidth() / 2 - 3) .. "       " .. string.rep(" ", treeWidth() / 2 - 2)
	else
		treespace = "%#TeBufTree#" .. string.rep(" ", treeWidth())
	end
	if counter < 2 or vim.o.columns < 120 then
		return treespace .. buffstart .. "%=" ..
			"%#TeBufRun#" .. run .. "%#TeBufSplit#" .. split .. "%#TeBufTheme#" .. theme .. "%#TeBufQuit#" .. quit
	end
	if counter > 1 then
		buffstart = "%#TeBufEmptyColor#"
	end
	return treespace ..
		buffstart ..
		buffline ..
		"%=" .. "%#TeBufRun#" .. run .. "%#TeBufSplit#" .. split .. "%#TeBufTheme#" .. theme .. "%#TeBufQuit#" .. quit
end

M.setup = function()
	if #vim.fn.getbufinfo { buflisted = 1 } >= 1 then
		vim.o.showtabline = 2
		vim.o.tabline = '%!v:lua.require("ui.tebufline").getTabline()'
	end
end

return M
