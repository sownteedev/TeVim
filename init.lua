-- NOTE: Author : Nguyen Thanh Son - SownteeNguyen
-- NOTE: Github : @sownteedev

------------------------------- WELCOME TO TEVIM -------------------------------
-- WARNING: THIS IS A PERSONAL CONFIGURATION NOT A DISTRO, YOU CAN USE DEFAULT CONFIGURATION OR CUSTOMIZE IT

require("tevim.core")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	require("tevim.core.utils").lazy(lazypath)
end
vim.opt.rtp:prepend(lazypath)
require("tevim.plugins")
