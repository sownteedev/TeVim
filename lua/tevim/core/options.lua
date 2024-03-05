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
	mouse = "a",
	cursorline = true,
	showmode = false,
	laststatus = 3,
	showtabline = 2,
	splitbelow = true,
	splitright = true,
	termguicolors = true,
	timeoutlen = 300,
	updatetime = 200,
	fillchars = { eob = " ", foldopen = "", foldsep = " ", foldclose = "", lastline = " " },
	listchars = "tab:  ",
}

vim.opt.shortmess:append("sI")
vim.opt.formatoptions:remove("c", "r", "o")
vim.opt.whichwrap:append("<>[]hl")

local globals = {
	mapleader = " ",
	maplocalleader = " ",
	speeddating_no_mappings = 1,
	TeVimTheme = "yoru",
	themeCache = vim.fn.stdpath("data") .. "/colors_data/",
	transparency = false,
	snipmate_snippets_path = "",
	loadTeDash = true,
}

local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

local builtins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"logipat",
	"matchit",
	"tutor",
	"rplugin",
	"syntax",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
	"archlinux",
	"fzf",
	"tutor_mode_plugin",
	"sleuth",
	"vimgrep",
}

for _, plugin in ipairs(builtins) do
	vim.g["loaded_" .. plugin] = 1
end
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

for k, v in pairs(options) do
	if vim.fn.has("nvim-0.10") == 1 then
		vim.loader.enable()
		vim.opt.smoothscroll = true
	end
	vim.opt[k] = v
end

for k, v in pairs(globals) do
	vim.g[k] = v
end
