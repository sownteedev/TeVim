local opts = { noremap = true, silent = true }
local map = vim.keymap.set

map("n", "<C-a>", "ggVG", opts, { desc = "Select All" })
map("v", "<C-c>", "y", opts, { desc = "Copy" })
map("n", "<C-v>", "p", opts, { desc = "Paste" })

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

map("n", "<C-s>", "<cmd>w<CR>", opts, { desc = "Save" })
map("i", "<C-s>", "<ESC>:w<CR>", opts, { desc = "Save (Insert)" })

map("n", "<M-Up>", ":m-2<CR>", opts, { desc = "Move Line Up" })
map("n", "<M-Down>", ":m+<CR>", opts, { desc = "Move Line Down" })
map("i", "<M-Up>", "<Esc>:m-2<CR>", opts, { desc = "Move Line Up (Insert)" })
map("i", "<M-Down>", "<Esc>:m+<CR>", opts, { desc = "Move Line Down (Insert)" })
map("x", "<M-Up>", ":move '<-2<CR>gv-gv", opts, { desc = "Move Line Up (Visual)" })
map("x", "<M-Down>", ":move '>+1<CR>gv-gv", opts, { desc = "Move Line Down (Visual)" })

map("n", "<C-Up>", ":resize +2<CR>", opts, { desc = "Resize Window Up" })
map("n", "<C-Down>", ":resize -2<CR>", opts, { desc = "Resize Window Down" })
map("n", "<C-Left>", ":vertical resize +2<CR>", opts, { desc = "Resize Window Left" })
map("n", "<C-Right>", ":vertical resize -2<CR>", opts, { desc = "Resize Window Right" })

map("i", "<C-j>", "<Down>", opts, { desc = "Move Cursor Down in Insert Mode" })
map("i", "<C-k>", "<Up>", opts, { desc = "Move Cursor Up in Insert Mode" })
map("i", "<C-h>", "<Left>", opts, { desc = "Move Cursor Left in Insert Mode" })
map("i", "<C-l>", "<Right>", opts, { desc = "Move Cursor Right in Insert Mode" })

map("n", "<TAB>", "<cmd>TeBufNext<CR>", opts, { desc = "Next Buffer" })
map("n", "<S-TAB>", "<cmd>TeBufPrev<CR>", opts, { desc = "Previous Buffer" })

map("n", "<Enter>", "<cmd>nohlsearch<CR>", opts, { desc = "Clear Highlight" })

map("n", "<leader>rn", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = true }, { desc = "Rename" })
