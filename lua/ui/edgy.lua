require("edgy").setup {
	bottom = {
		{
			title = "TERMINAL",
			ft = "toggleterm",
			size = { height = 0.4 },
			filter = function(buf, win)
				return vim.api.nvim_win_get_config(win).relative == ""
			end,
		},
		{
			ft = "Trouble",
			title = "TROUBLE",
			open = "Trouble",
		},
		{ ft = "qf",            title = "QuickFix" },
		{
			title = "HELP",
			ft = "help",
			size = { height = 20 },
			filter = function(buf)
				return vim.bo[buf].buftype == "help"
			end,
		},
		{ ft = "spectre_panel", size = { height = 0.4 } },
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
		-- {
		--     title = "Git",
		--     ft = "neo-tree",
		--     filter = function(buf)
		--         return vim.b[buf].neo_tree_source == "git_status"
		--     end,
		--     pinned = true,
		--     open = "Neotree position=right git_status",
		-- },
		-- {
		--     title = "Buffers",
		--     ft = "neo-tree",
		--     filter = function(buf)
		--         return vim.b[buf].neo_tree_source == "buffers"
		--     end,
		--     pinned = true,
		--     open = "Neotree position=top buffers",
		-- },
		{
			title = "OUTLINE",
			ft = "Outline",
			pinned = true,
			open = "SymbolsOutlineOpen",
		},
	},
	options = {
		left = { size = 30 },
		bottom = { size = 10 },
		right = { size = 30 },
		top = { size = 10 },
	},
	animate = {
		enabled = true,
		fps = 60,
		cps = 120,
		on_begin = function()
			vim.g.minianimate_disable = true
		end,
		on_end = function()
			vim.g.minianimate_disable = false
		end,
		spinner = {
			frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
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
	fix_win_height = vim.fn.has("nvim-0.10.0") == 0,
}
