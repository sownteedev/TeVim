local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('Setup', {})

-- Load Statusline, TabBufline and Themes
autocmd({ "UIEnter" }, {
	callback = function()
		require("themes").load()
		require("ui.statusline").setup()
		require("ui.tabbufline").setup()
	end
})

-- Open Float Window for LSP Diagnostics
autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		vim.diagnostic.open_float({ scope = "cursor", focusable = false })
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

-- Disable fold in Outline
autocmd("FileType", {
	pattern = "Outline",
	callback = function()
		vim.opt_local.foldcolumn = "0"
		vim.opt_local.stc = ""
	end,
})

-- Terminal
autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.opt.number = false
		vim.opt_local.cursorline = false
		vim.cmd("startinsert")
	end,
})

-- Hide cursorline in insert mode
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, { command = 'set cursorline', group = group })
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, { command = 'set nocursorline', group = group })
