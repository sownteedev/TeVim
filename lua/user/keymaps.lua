--  _____
-- |  __ \
-- | |__) |___ _ __ ___   __ _ _ __  ___
-- |  _  // _ \ '_ ` _ \ / _` | '_ \/ __|
-- | | \ \  __/ | | | | | (_| | |_) \__ \
-- |_|  \_\___|_| |_| |_|\__,_| .__/|___/
--                            | |
--                            |_|

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Increase or Decrease value
keymap("n", "+", "<C-a>", opts)
keymap("n", "-", "<C-x>", opts)

-- Select all, Copy and Paste
keymap("n", "<C-a>", "ggVG", opts)
keymap("v", "<C-c>", "y", opts)
keymap("n", "<C-v>", "p", opts)

-- Move the cursor between windows
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Save
keymap("n", "<C-s>", "<cmd>w<CR>", opts)
keymap("i", "<C-s>", "<ESC>:w<CR>", opts)

-- Move the line up and down
keymap("n", "<M-Up>", ":m-2<CR>", opts)
keymap("n", "<M-Down>", ":m+<CR>", opts)
keymap("i", "<M-Up>", "<Esc>:m-2<CR>", opts)
keymap("i", "<M-Down>", "<Esc>:m+<CR>", opts)

-- Resize window
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Move cursor in Insert Mode
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-l>", "<Right>", opts)

-- Move between buffers
keymap("n", "<TAB>", "<cmd>bnext<CR>", opts)

-- Split window and hozirontal window
keymap("n", "<leader>wv", "<C-w>v", opts)
keymap("n", "<leader>wh", "<C-w>s", opts)

-- Clear search when esc esc
keymap("n", "<esc><esc>", "<cmd>nohlsearch<cr>", opts)

----------------------------------------------- PLUGINS -------------------------------------------

-- Expoler
keymap("n", "<C-e>", "<cmd>Neotree<cr>", opts)

-- Telescope
keymap("n", "<S-TAB>",
	"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false, no_ignore=true, follow=true, hidden=true})<cr>",
	opts
)

-- Copilot
vim.cmd([[imap <silent><script><expr> <C-c> copilot#Accept("\<CR>")]])
vim.cmd([[imap <silent><script><expr> <C-Down> copilot#Next("\<CR>")]])
vim.cmd([[imap <silent><script><expr> <C-Up> copilot#Previous("\<CR>")]])
