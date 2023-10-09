require("edgy").setup {
	bottom = {
		{
			ft = "Trouble",
			title = "TROUBLE",
			open = "Trouble",
		},
		{ ft = "qf", title = "QuickFix" },
		{
			title = "HELP",
			ft = "help",
			size = { height = 20 },
			filter = function(buf)
				return vim.bo[buf].buftype == "help"
			end,
		},
	},
	left = {
		{
			title = "EXPLORER",
			ft = "neo-tree",
			filter = function(buf)
				return vim.b[buf].neo_tree_source == "filesystem"
			end,
			size = { height = 0.5 },
		},
		{
			title = "OUTLINE",
			ft = "Outline",
			pinned = false,
			open = "SymbolsOutline",
		},
	},
	options = {
		left = { size = 33 },
		bottom = { size = 10 },
		right = { size = 0 },
		top = { size = 0 },
	},
	animate = {
		enabled = true,
		fps = 165,
		cps = 165,
		on_begin = function()
			vim.g.minianimate_disable = true
		end,
		on_end = function()
			vim.g.minianimate_disable = false
		end,
		spinner = {
			frames = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" },
			interval = 100,
		},
	},
	exit_when_last = true,
	wo = {
		winbar = true,
		winfixwidth = false,
		winfixheight = false,
		winhighlight = "WinBar:EdgyWinBar,Normal:EdgyNormal",
		spell = false,
		signcolumn = "no",
	},
	icons = {
		closed = "",
		open = "",
	},
	fix_win_height = true
}
