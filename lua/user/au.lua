local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local colors = require("themes").getCurrentTheme()

-- Load Themes
autocmd({ "UIEnter" }, {
	callback = function()
		require("themes").load()
	end
})

-- Load Statusline
autocmd({ "ModeChanged", "CursorHold" }, {
	callback = function()
		require("ui.statusline").setup()
		require("ui.tabbufline").setup()
	end
})

-- Highlight yanked text
autocmd("TextYankPost", {
	group = augroup("yank_highlight", {}),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
})

-- Smart Number
autocmd("InsertEnter", {
	command = "set norelativenumber",
	pattern = "*"
})
autocmd("InsertLeave", {
	command = "set relativenumber",
	pattern = "*"
})

-- Disable fold in Outline
autocmd("FileType", {
	pattern = "Outline",
	callback = function()
		vim.opt_local.foldcolumn = "0"
		vim.opt_local.stc = ""
		vim.api.nvim_set_hl(0, "WinSeparator", { bg = colors.darker_black, fg = colors.darker_black })
	end,
})

-- Smart term
autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
		vim.cmd("startinsert")
	end,
})
