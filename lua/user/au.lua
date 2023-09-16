local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local colors = require("themes").getCurrentTheme()

-- Load Themes
autocmd({ "UIEnter" }, {
	callback = function()
		vim.api.nvim_set_hl(0, "StatusLine", { bg = colors.black })
		require("themes").load()
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

-- PackerSync if save plugins.lua
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]
