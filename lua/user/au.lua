local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

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
		vim.diagnostic.open_float()
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

-- Smart term
autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
		vim.cmd("startinsert")
	end,
})
