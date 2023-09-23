local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local general = augroup("General Settings", { clear = true })

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
	end,
})

-- Smart Term
autocmd("TermOpen", {
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
		vim.cmd "startinsert!"
	end,
	group = general,
	desc = "Terminal Options",
})
