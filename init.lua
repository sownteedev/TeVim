-- Author : Nguyen Thanh Son - SownteeNguyen
-- Github : @sownteedev

------------------------------- WELCOME TO TEVIM -------------------------------

vim.loader.enable()
require "tevim.user"

--- @diagnostic disable warning
local function echo(str)
	vim.cmd "redraw"
	vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	echo("Hi there, welcome to TEVIM 󱠡")
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
		lazypath })
end
vim.opt.rtp:prepend(lazypath)

require "lazy".setup({
	spec = { { import = "tevim.plugins" }},
	ui = {
		icons = {
			ft = "",
			lazy = "󰂠 ",
			loaded = "",
			not_loaded = "",
		},
	},
})
