vim.loader.enable()
local options = {
	number = true,
	relativenumber = false,
	ruler = false,
	shiftwidth = 4,
	tabstop = 4,
	softtabstop = 4,
	smartindent = true,
	smartcase = true,
	ignorecase = true,
	clipboard = "unnamedplus",
	undofile = true,
	swapfile = false,
	mouse = "a",
	cursorline = true,
	showmode = false,
	winbar = "",
	laststatus = 3,
	showtabline = 2,
	splitbelow = true,
	splitright = true,
	termguicolors = true,
	timeoutlen = 300,
	updatetime = 200,
	fillchars = { eob = " ", foldopen = "", foldsep = " ", foldclose = "", lastline = " " },
	listchars = "tab:  ",
	background = "light",
}
vim.opt.shortmess:append("sI")
vim.opt.formatoptions:remove("c", "r", "o")
vim.opt.whichwrap:append("<>[]hl")

local globals = {
	mapleader = " ",
	maplocalleader = " ",
	speeddating_no_mappings = 1,
	TeVimTheme = "yoru",
	transparency = false,
	loadTeDash = true,
	loadTeBufLine = true,
	loadTeStatusLine = true,
	loadTeVimTheme = true,
}

local is_windows = vim.uv.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

for k, v in pairs(options) do
	vim.opt[k] = v
end

for k, v in pairs(globals) do
	vim.g[k] = v
end
