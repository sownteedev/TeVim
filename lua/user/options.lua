vim.cmd("filetype plugin indent off")
vim.cmd("syntax off")

vim.g.currentTheme = "decaydark"
vim.g.theme_cache = vim.fn.stdpath "data" .. "/colors_data/"

local options = {
	-- NUMBER
	number = true,
	relativenumber = true,
	ruler = true,
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
	hidden = true,
	clipboard = "unnamedplus",
	showcmd = true,
	cmdheight = 0,
	writebackup = false,
	swapfile = false,
	completeopt = { "menu", "menuone", "noselect" },
	undofile = true,
	mouse = "a",
	cursorline = true,
	mousemoveevent = true,
	title = true,
	conceallevel = 0,
	hlsearch = true,
	pumheight = 10,
	showmode = true,
	showtabline = 1,
	laststatus = 3,
	signcolumn = "yes",
	splitbelow = true,
	splitright = true,
	termguicolors = true,
	timeoutlen = 400,
	updatetime = 0,
	wrap = true,
	scrolloff = 8,
	sidescrolloff = 8,
	backspace = "indent,eol,start",
	list = true,
	splitkeep = "screen",
	-- FOLD
	foldenable = true,
	foldcolumn = '1',
	foldlevelstart = 99,
}

vim.opt.listchars = "tab:  "
vim.opt.fillchars = { eob = " ", foldopen = "", foldsep = " ", foldclose = "" }
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.shortmess:append("sI")

for k, v in pairs(options) do
	vim.opt[k] = v
end
