local M = {}
-- Commands
vim.cmd("function! TeBufGoToBuf(bufnr,b,c,d) \n execute 'b'..a:bufnr \n endfunction")
vim.cmd("function! ToggleTheme(a,b,c,d) \n TeVimThemes \n endfunction")
vim.cmd("function! ToggleTrans(a,b,c,d) \n TeVimToggleTrans \n endfunction")
vim.cmd("function! Split(a,b,c,d) \n vsplit \n endfunction")
vim.cmd("function! Run(a,b,c,d) \n lua require('tevim.core.utils').build_run() \n endfunction")
vim.cmd("function! Quit(a,b,c,d) \n qa! \n endfunction")
vim.cmd("function! TeBufKillBuf(a,b,c,d) \n TeBufKillBuf \n endfunction")

-------------------------------------------------------------------------

local function new_hl(group1, group2)
	local fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group1)), "fg#")
	local bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group2)), "bg#")
	vim.api.nvim_set_hl(0, "TeBuf" .. group1 .. group2, { fg = fg, bg = bg })
	return "%#" .. "TeBuf" .. group1 .. group2 .. "#"
end

local devicons_present, devicons = pcall(require, "nvim-web-devicons")

local createTab = function(buf)
	if devicons_present then
		local filename = (#vim.api.nvim_buf_get_name(buf) ~= 0)
				and vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
			or ""
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
			if
				vim.api.nvim_buf_is_valid(buffer)
				and vim.api.nvim_buf_is_loaded(buffer)
				and vim.bo[buffer].buflisted
				and filename ~= ""
				and filename == vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buffer), ":t")
				and buffer ~= buf
			then
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

					if value_current ~= other_current and buf == vim.api.nvim_get_current_buf() then
						filename = "%#TeBufFolderOnActive#" .. value_current .. "/" .. "%#TeBufOnActive#" .. filename
						break
					elseif value_current ~= other_current and buf ~= vim.api.nvim_get_current_buf() then
						filename = "%#TeBufFolderOnInactive#"
							.. value_current
							.. "/"
							.. "%#TeBufOnInactive#"
							.. filename
						break
					end
				end
				break
			end
		end
		if buf == vim.api.nvim_get_current_buf() then
			filename = "%#TeBufOnActive#" .. "   " .. icon .. "  " .. "%#TeBufOnActive#" .. filename
			close_btn = (vim.bo[0].modified and "%" .. buf .. "@BufflineKillBuf@%#TeBufOnModified#●   ")
				or ("%#TeBufOnClose#" .. close_btn) .. "   "
		else
			filename = "%#TeBufOnInactive#" .. "   " .. icon .. "  " .. "%#TeBufOnInactive#" .. filename
			close_btn = (vim.bo[buf].modified and "%" .. buf .. "@BufflineKillBuf@%#TeBufOffModified#●   ")
				or ("%#TeBufOffClose#" .. close_btn) .. "   "
		end
		return "%" .. buf .. "@TeBufGoToBuf@" .. filename .. "  " .. close_btn .. "%X" .. "%#TeBufEmptyColor#"
	end
end

local excludedFileTypes = { "neo-tree", "help", "dasher", "lir", "alpha", "toggleterm", "dashboard" }

local treeWidth = function()
	for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.bo[vim.api.nvim_win_get_buf(win)].ft == "neo-tree" then
			return vim.api.nvim_win_get_width(win)
		end
	end
	return 0
end

M.getTabline = function()
	local treespace = "%#TeBufTree#" .. string.rep(" ", treeWidth())
	local buffline = ""
	local buffstart = "%#TeBufEmpty#"
	local run = "%@Run@" .. ""
	local listrun = {
		c = "c",
		cpp = "cpp",
		lua = "lua",
		python = "python",
		rust = "rust",
		javascript = "javascript",
		typescript = "typescript",
		go = "go",
		php = "php",
		java = "java",
		cs = "cs",
		dart = "dart",
		sh = "sh",
	}
	if vim.bo.filetype == "html" or vim.bo.filetype == "markdown" then
		run = "%@Run@" .. " 󰀂 "
	elseif listrun[vim.bo.filetype] then
		run = "%@Run@" .. "  "
	end

	local split = "%@Split@" .. "  "
	local trans = "%@ToggleTrans@" .. " 󱡓 "
	local theme = "%@ToggleTheme@" .. "   "
	local quit = "%@Quit@" .. " 󰅙 "
	local counter = 0
	for _, buf in pairs(vim.api.nvim_list_bufs()) do
		local filename = vim.api.nvim_buf_get_name(buf):match("^.+/(.+)$") or ""
		if
			vim.api.nvim_buf_is_valid(buf)
			and vim.api.nvim_buf_is_loaded(buf)
			and vim.bo[buf].buflisted
			and filename ~= ""
		then
			local conditions = vim.tbl_contains(excludedFileTypes, vim.bo[buf].ft)
			if conditions then
				goto do_nothing
			else
				filename = "%#TeBufEmptyColor#" .. createTab(buf)
			end
			buffline = buffline .. filename
			counter = counter + 1
		end
		::do_nothing::
	end
	if counter < 2 or vim.o.columns < 120 then
		return treespace
			.. buffstart
			.. "%="
			.. "%#TeBufRun#"
			.. run
			.. "%#TeBufSplit#"
			.. split
			.. "%#TeBufTrans#"
			.. trans
			.. "%#TeBufTheme#"
			.. theme
			.. "%#TeBufQuit#"
			.. quit
	end
	return treespace
		.. buffline
		.. "%="
		.. "%#TeBufRun#"
		.. run
		.. "%#TeBufSplit#"
		.. split
		.. "%#TeBufTrans#"
		.. trans
		.. "%#TeBufTheme#"
		.. theme
		.. "%#TeBufQuit#"
		.. quit
end

local tebufilter = function()
	local bufs = vim.api.nvim_list_bufs() or nil
	if not bufs then
		return {}
	end
	for i = #bufs, 1, -1 do
		local filename = (#vim.api.nvim_buf_get_name(bufs[i]) ~= 0)
				and vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufs[i]), ":t")
			or ""
		if
			not vim.api.nvim_buf_is_valid(bufs[i])
			or not vim.bo[bufs[i]].buflisted
			or not vim.api.nvim_buf_is_loaded(bufs[i])
			or filename == ""
		then
			table.remove(bufs, i)
		end
	end
	return bufs
end

local tebuflinePrev = function()
	local bufs = tebufilter()
	for i, v in ipairs(bufs) do
		if vim.api.nvim_get_current_buf() == v then
			vim.cmd(i == 1 and "b" .. bufs[#bufs] or "b" .. bufs[i - 1])
			break
		end
	end
end

local tebuflineNext = function()
	local bufs = tebufilter()
	for i, v in ipairs(bufs) do
		if vim.api.nvim_get_current_buf() == v then
			vim.cmd(i == #bufs and "b" .. bufs[1] or "b" .. bufs[i + 1])
			break
		end
	end
end

local close_buffer = function(bufnr)
	if vim.bo.buftype == "terminal" then
		vim.cmd(vim.bo.buflisted and "set nobl | enew" or "hide")
	else
		bufnr = bufnr or vim.api.nvim_get_current_buf()
		if bufnr == vim.api.nvim_get_current_buf() then
			tebuflinePrev()
		end
		vim.cmd("confirm bd" .. bufnr)
	end
end

local close_other_buffers = function()
	local bufs = tebufilter()
	local current_buf = vim.api.nvim_get_current_buf()
	for _, v in ipairs(bufs) do
		if v ~= current_buf then
			vim.cmd("confirm bd" .. v)
		end
	end
	vim.cmd("redrawtabline")
end

M.setup = function()
	vim.api.nvim_create_user_command("TeBufPrev", function()
		tebuflinePrev()
	end, {})
	vim.api.nvim_create_user_command("TeBufNext", function()
		tebuflineNext()
	end, {})
	vim.api.nvim_create_user_command("TeBufCloseOtherBuf", function()
		close_other_buffers()
	end, {})
	vim.api.nvim_create_user_command("TeBufKillBuf", function()
		close_buffer(vim.api.nvim_get_current_buf())
	end, {})
	if #vim.fn.getbufinfo({ buflisted = 1 }) >= 1 or #vim.api.nvim_list_tabpages() >= 2 then
		vim.o.showtabline = 2
		vim.o.tabline = '%!v:lua.require("tevim.ui.tebufline").getTabline()'
	end
	vim.cmd([[
		nnoremap <silent><TAB> :TeBufNext<CR>
		nnoremap <silent><S-TAB> :TeBufPrev<CR>
		nnoremap <silent><C-o> :TeBufCloseOtherBuf<CR>
		nnoremap <silent><C-q> :TeBufKillBuf<CR>
	]])
end

return M
