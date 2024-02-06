vim.cmd([[
	syntax off
	filetype off
	filetype plugin indent off
]])

local options = {
	number = true,
	relativenumber = false,
	numberwidth = 5,
	expandtab = false,
	smarttab = true,
	shiftwidth = 4,
	tabstop = 4,
	softtabstop = 4,
	smartindent = true,
	autoindent = true,
	cindent = true,
	smartcase = true,
	ignorecase = true,
	fileencoding = "utf-8",
	encoding = "utf-8",
	backup = false,
	clipboard = "unnamedplus",
	writebackup = false,
	swapfile = false,
	completeopt = { "menu", "menuone", "noselect" },
	pumheight = 10,
	backspace = "indent,eol,start",
	undofile = true,
	mouse = "a",
	mousemoveevent = true,
	cursorline = true,
	title = true,
	conceallevel = 0,
	hlsearch = true,
	showmode = false,
	laststatus = 0,
	showtabline = 3,
	splitbelow = true,
	splitright = true,
	termguicolors = true,
	timeoutlen = 100,
	updatetime = 300,
	wrap = true,
	list = true,
	splitkeep = "screen",
	fillchars = { eob = " ", foldopen = "", foldsep = " ", foldclose = "", lastline = " " },
	listchars = "tab:  ",
	foldenable = true,
	foldcolumn = "1",
	foldlevelstart = 99,
}

vim.opt.shortmess:append("sI")
vim.opt.formatoptions:remove("c", "r", "o")

local globals = {
	mapleader = " ",
	maplocalleader = " ",
	speeddating_no_mappings = 1,
	TeVimTheme = "yoru",
	theme_cache = vim.fn.stdpath("data") .. "/colors_data/",
	transparency = false,
	load_tedash_on_startup = true,
	snipmate_snippets_path = "",
}

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
