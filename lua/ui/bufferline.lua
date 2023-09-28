local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

local colors = require("themes").getCurrentTheme()

bufferline.setup({
	options = {
		mode = "buffers",
		numbers = "none",
		close_command = "bd! %d",
		right_mouse_command = "bd! %d",
		left_mouse_command = "buffer %d",
		indicator = { icon = "|", style = "none" },
		buffer_close_icon = "󰅙",
		modified_icon = "●",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 20,
		max_prefix_length = 20,
		tab_size = 25,
		enforce_regular_tabs = true,
		hover = {
			enabled = true,
			delay = 0,
			reveal = { 'close' }
		},
		custom_areas = {
			right = function()
				vim.cmd "function! ToggleTheme(a,b,c,d) \n lua require('themes.switch').toggleTheme() \n endfunction"
				vim.cmd "function! Quit(a,b,c,d) \n lua require('user.functions').toQuitAll() \n endfunction"
				vim.cmd "function! Run(a,b,c,d) \n lua require('user.functions').build_run() \n endfunction"
				vim.cmd "function! Split(a,b,c,d) \n lua require('user.functions').toSplit() \n endfunction"
				local run = "%@Run@" .. "  "
				local theme = "%@ToggleTheme@" .. "   "
				local split = "%@Split@" .. "  "
				local quit = "%@Quit@" .. "  "
				local result = {}
				table.insert(result, { text = run, fg = colors.yellow, bg = colors.one_bg2 })
				table.insert(result, { text = split, fg = colors.blue, bg = colors.one_bg2 })
				table.insert(result, { text = theme, fg = colors.green, bg = colors.one_bg2 })
				table.insert(result, { text = quit, fg = colors.black, bg = colors.red })
				return result
			end,
			left = function()
			end
		},
	}
})

local Offset = require("bufferline.offset")
if not Offset.edgy then
	local get = Offset.get
	Offset.get = function()
		if package.loaded.edgy then
			local layout = require("edgy.config").layout
			local ret = { left = "", left_size = 0, right = "", right_size = 0 }
			for _, pos in ipairs({ "left", "right" }) do
				local sb = layout[pos]
				if sb and #sb.wins > 0 then
					local title = "                           " .. string.rep(" ", sb.bounds.width - 26)
					ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#%*"
					ret[pos .. "_size"] = sb.bounds.width
				end
			end
			ret.total_size = ret.left_size + ret.right_size
			if ret.total_size > 0 then
				return ret
			end
		end
		return get()
	end
	Offset.edgy = true
end
