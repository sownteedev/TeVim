-- NOTE: Author : Nguyen Thanh Son - SownteeNguyen
-- NOTE: Github : @sownteedev

------------------------------- WELCOME TO TEVIM -------------------------------
-- WARNING: THIS IS A PERSONAL CONFIGURATION NOT A DISTRO, YOU CAN USE DEFAULT CONFIGURATION OR CUSTOMIZE IT

require("tevim.core")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	require("tevim.themes").load()
	vim.cmd("redraw")
	vim.api.nvim_echo({ { "Hi there, welcome to TEVIM 󱠡 ", "Bold" } }, true, {})
	local repo = "https://github.com/folke/lazy.nvim.git"
	local output = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath })
	assert(vim.v.shell_error == 0, "External call failed with error code: " .. vim.v.shell_error .. "\n" .. output)
	vim.opt.rtp:prepend(lazypath)
	require("tevim.plugins")
	vim.cmd("TeVimCheckMason")
	vim.cmd("redraw")
	vim.api.nvim_echo({ { "Wait for everything install. Reopen Neovim then ENJOY!", "Bold" } }, true, {})
end
vim.opt.rtp:prepend(lazypath)
require("tevim.plugins")
