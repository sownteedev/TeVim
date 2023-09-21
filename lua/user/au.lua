local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

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

-- PackerSync if save plugins.lua
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]
