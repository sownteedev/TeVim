vim.cmd("filetype plugin indent off")
vim.cmd("syntax off")

vim.g.currentTheme = "everblush"
vim.g.theme_cache = vim.fn.stdpath "data" .. "/colors_data/"

local options = {
	-- NUMBER
	number = true,
	relativenumber = false,
	numberwidth = 5,
	-- INDENT
	expandtab = false,
	smarttab = true,
	shiftwidth = 4,
	tabstop = 4,
	softtabstop = 4,
	smartindent = true,
	autoindent = true,
	cindent = true,
	-- OTHER
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
	cursorline = false,
	title = true,
	conceallevel = 0,
	hlsearch = true,
	showmode = false,
	showtabline = 1,
	laststatus = 3,
	splitbelow = true,
	splitright = true,
	termguicolors = true,
	timeoutlen = 100,
	updatetime = 300,
	wrap = true,
	list = true,
	splitkeep = "screen",
	-- FOLD
	foldenable = true,
	foldcolumn = '1',
	foldlevelstart = 99,
}

local globals = {
	mapleader = ' ',
	maplocalleader = ' ',
	speeddating_no_mappings = 1,
}

vim.opt.listchars = "tab:  "
vim.opt.fillchars = { eob = " ", foldopen = "", foldsep = " ", foldclose = "" }
vim.opt.shortmess:append "sI"
vim.opt.formatoptions:remove('c', 'r', 'o');

-- COPILOT
vim.g.copilot_no_tab_map = true;
vim.g.copilot_assume_mapped = true;
vim.g.copilot_tab_fallback = "";

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
	"vimgrep"
}

for _, plugin in ipairs(builtins) do
	vim.g["loaded_" .. plugin] = 1
end

for k, v in pairs(options) do
	vim.opt[k] = v
end

for k, v in pairs(globals) do
	vim.g[k] = v
end
