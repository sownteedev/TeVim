local opts = { noremap = true, silent = true }
local map = vim.keymap.set

map({ "n", "v" }, "<C-a>", "ggVG", opts, { desc = "Select All" })
map("v", "<C-c>", "y", opts, { desc = "Copy" })
map({ "n", "i" }, "<C-v>", "<ESC>pa", opts, { desc = "Paste" })
map({ "n", "v" }, "<C-x>", "d", opts, { desc = "Cut" })

map(
	"n",
	"j",
	'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
	{ expr = true },
	{ desc = "Move Cursor Down (Allow Wrapped)" }
)
map(
	"n",
	"k",
	'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
	{ expr = true },
	{ desc = "Move Cursor Up (Allow Wrapped)" }
)

map("n", "<C-h>", "<C-w>h", opts, { desc = "Move Cursor Left Buffer" })
map("n", "<C-j>", "<C-w>j", opts, { desc = "Move Cursor Down Buffer" })
map("n", "<C-k>", "<C-w>k", opts, { desc = "Move Cursor Up Buffer" })
map("n", "<C-l>", "<C-w>l", opts, { desc = "Move Cursor Right Buffer" })

map({ "n", "i" }, "<C-s>", "<ESC>:w<CR>", opts, { desc = "Save" })
map({ "n", "v" }, "<Leader>q", "<cmd>qa!<CR>", opts, { desc = "Quit" })

map({ "n", "i" }, "<M-Up>", "<Esc>:m-2<CR>", opts, { desc = "Move Line Up (Insert)" })
map({ "n", "i" }, "<M-Down>", "<Esc>:m+<CR>", opts, { desc = "Move Line Down (Insert)" })
map("x", "<M-Up>", ":move '<-2<CR>gv-gv", opts, { desc = "Move Line Up (Visual)" })
map("x", "<M-Down>", ":move '>+1<CR>gv-gv", opts, { desc = "Move Line Down (Visual)" })

map({ "n", "v" }, "<C-Up>", ":resize +2<CR>", opts, { desc = "Resize Window Up" })
map({ "n", "v" }, "<C-Down>", ":resize -2<CR>", opts, { desc = "Resize Window Down" })
map({ "n", "v" }, "<C-Left>", ":vertical resize +2<CR>", opts, { desc = "Resize Window Left" })
map({ "n", "v" }, "<C-Right>", ":vertical resize -2<CR>", opts, { desc = "Resize Window Right" })

map("i", "<C-j>", "<Down>", opts, { desc = "Move Cursor Down in Insert Mode" })
map("i", "<C-k>", "<Up>", opts, { desc = "Move Cursor Up in Insert Mode" })
map("i", "<C-h>", "<Left>", opts, { desc = "Move Cursor Left in Insert Mode" })
map("i", "<C-l>", "<Right>", opts, { desc = "Move Cursor Right in Insert Mode" })

map("n", "<Enter>", "<cmd>nohlsearch<CR>", opts, { desc = "Clear Highlight" })
