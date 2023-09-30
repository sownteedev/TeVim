-- SETUP BY Nguyen Thanh Son - SownteeNguyen --
-- Github : @sownteedev --

-- WELCOME TO TEVIM --

require("user.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

require("lazy").setup("plugins")

require("plugins")

require("user.keymaps")

require("user.au")
