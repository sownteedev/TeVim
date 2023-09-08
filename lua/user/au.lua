local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Require theme color you're using
-- Select themes when open neovim
local colors = require('themes.schemes.yoru').get_colors()
autocmd("VimEnter", {
	vim.api.nvim_set_hl(0, "TelescopeBackground", { bg = colors.darker_black }),
	vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = colors.darker_black }),
	vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.darker_black, bg = colors.darker_black }),
	vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = colors.darker_black, bg = colors.darker_black }),
	vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = colors.black2, bg = colors.red }),
	vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = colors.black2, bg = colors.black2 }),
	vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = colors.white, bg = colors.black2 }),
	vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = colors.white, bg = colors.black2, italic = true, bold = true }),
	vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.black }),
	vim.api.nvim_set_hl(0, "Folded", { bg = colors.black }),
	vim.api.nvim_set_hl(0, "FoldColumn", { bg = colors.black }),
	vim.api.nvim_set_hl(0, "SignColumn", { bg = colors.black }),
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.black }),
	vim.api.nvim_set_hl(0, "StatusLine", { bg = colors.black }),

	command = "lua require('themes.switch').setup(require('telescope.themes').get_dropdown{})",
	pattern = "*"
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
