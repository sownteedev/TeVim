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
local map = vim.keymap.set

-- Select all, Copy and Paste
keymap("n", "<C-a>", "ggVG", opts)
keymap("v", "<C-c>", "y", opts)
keymap("n", "<C-v>", "p", opts)

-- Allow moving the cursor through wrapped lines
keymap("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
keymap("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

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
keymap("x", "<M-Up>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<M-Down>", ":move '>+1<CR>gv-gv", opts)

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

-- Next buffers
keymap("n", "<TAB>", "<cmd>TeBufNext<CR>", opts)

-- Clear search
keymap("n", "<C-Enter>", ":nohlsearch<CR>", opts)

-- Rename
map("n", "<leader>rn", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Reload all
map("n", "<leader>rl", [[:so %<CR>]], opts)

----------------------------------------------- PLUGINS -------------------------------------------

-- Explorer
keymap("n", "<C-e>", "<cmd>Neotree toggle<cr>", opts)

-- Toggle Term
keymap("n", [[<C-`>]], "<cmd>ToggleTerm size=10 direction=horizontal<cr>", opts)

-- Telescope
keymap("n", "<S-TAB>",
	"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false, follow=true, no_ignore=true, hidden=true})<cr>",
	opts)

-- Toggle Inlay Hints
if vim.lsp.inlay_hint then
	map("n", "<leader>lI", function() vim.lsp.inlay_hint(0, nil) end, opts)
end

-- Copilot
vim.cmd([[imap <silent><script><expr> <C-c> copilot#Accept("\<CR>")]])
