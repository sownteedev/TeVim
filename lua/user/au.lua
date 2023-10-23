local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('Setup', {})

autocmd({ "UIEnter" }, {
	callback = function()
		require("themes").load()
		require("ui.testtline").setup()
		require("ui.tebufline").setup()
		require("ui.tedash").setup()
	end,
	desc = "Load Statusline, TabBufline, Dashboard and Themes"
})

autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		vim.diagnostic.open_float({ scope = "cursor", focusable = false })
	end,
	desc = "Open Float Window for LSP Diagnostics"
})

autocmd("TextYankPost", {
	group = augroup("yank_highlight", {}),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
	desc = "Highlight yanked text"
})

autocmd("FileType", {
	pattern = "Outline",
	callback = function()
		vim.opt_local.foldcolumn = "0"
		vim.opt_local.stc = ""
	end,
	desc = "Disable fold in Outline"
})

autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.opt.number = false
		vim.opt_local.cursorline = false
		vim.cmd("startinsert")
	end,
	desc = "Disable number and cursorline in terminal"
})

autocmd({ 'InsertLeave', 'WinEnter' }, { command = 'set cursorline', group = group, desc = "CursorLine" })
autocmd({ 'InsertEnter', 'WinLeave' }, { command = 'set nocursorline', group = group, desc = "CursorLine" })
