local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "UIEnter" }, {
	callback = function()
		require("themes").load()
		require("ui.testtline").setup()
		require("ui.tebufline").setup()
	end,
	desc = "Load Statusline, TabBufline, Dashboard and Themes"
})

autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		if vim.fn.argc() == 0 then
			require("ui.tedash").setup()
		end
	end,
	desc = "Load Dashboard"
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

autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.opt.number = false
		vim.opt_local.cursorline = false
		vim.cmd("startinsert")
	end,
	desc = "Disable number and cursorline in terminal"
})
