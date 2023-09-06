vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")

local options = {
    -- NUMBER
    number = true,
    relativenumber = true,
    ruler = true,
    numberwidth = 5,
    -- INDENT
    expandtab = true,
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
    wrap = false,
    scrolloff = 8,
    sidescrolloff = 8,
    backspace = "indent,eol,start",
    list = true,
    splitkeep = "screen",
    background = "dark",
    -- FOLD
    foldenable = true,
    foldcolumn = '1',
    foldlevelstart = 99,
    foldlevel = 99,
}

vim.opt.fillchars = { eob = " ", foldopen = "", foldsep = " ", foldclose = "" }
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.shortmess:append("sI")
-- vim.opt.listchars = "lead:·,trail:·,tab:··"

-- For Copilot
vim.g.copilot_no_tab_map = true

for k, v in pairs(options) do
    vim.opt[k] = v
end
