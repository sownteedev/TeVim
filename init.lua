-- SETUP BY Nguyen Thanh Son - SownteeNguyen --
-- Github : @sownteedev --

-- WELCOME TO TEVIM --

vim.loader.enable()
require("user.options")

local function echo(str)
	vim.cmd "redraw"
	vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	echo("Welcome to TEVIM   Installing lazy.nvim & plugins ...")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

require("lazy").setup("plugins")

require("user.keymaps")

require("user.au")
