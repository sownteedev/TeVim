local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "UIEnter" }, {
	callback = function()
		require("tevim.themes").load()
		require("tevim.ui.testtline").setup()
		require("tevim.ui.tebufline").setup()
		if vim.fn.argc() == 0 then
			require("tevim.ui.tedash").setup()
		end
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

autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.opt.number = false
		vim.opt_local.cursorline = false
		vim.cmd("startinsert")
	end,
	desc = "Disable number and cursorline in terminal"
})
