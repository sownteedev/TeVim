local plugins = {
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"MunifTanjim/nui.nvim",
	},
	{
		"nvim-tree/nvim-web-devicons",
		event = "BufRead",
		opts = function()
			require("nvim-web-devicons").set_default_icon("󰈚")
			return require("tevim.plugins.configs.devicons")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		keys = { { "<C-e>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" } },
		branch = "v3.x",
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
			if vim.fn.argc(-1) == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		opts = function()
			return require("tevim.plugins.configs.neotree")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSUninstall", "TSUpdate" },
		build = ":TSUpdate",
		dependencies = {
			"HiPhish/rainbow-delimiters.nvim",
			{
				"windwp/nvim-ts-autotag",
				ft = { "html", "javascript", "jsx", "typescript", "tsx", "svelte", "vue", "xml", "markdown" },
				opts = { enable_close_on_slash = false },
			},
		},
		opts = function()
			return require("tevim.plugins.configs.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		version = "2.20.7",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"echasnovski/mini.indentscope",
				opts = { symbol = "│" },
			},
		},
		opts = function()
			return require("tevim.plugins.configs.blankline")
		end,
	},
	{
		"folke/which-key.nvim",
		keys = { "<leader>", " ", "'", "`" },
		cmd = "WhichKey",
		opts = function()
			return require("tevim.plugins.configs.whichkey")
		end,
		config = function(_, opts)
			require("which-key").setup(opts.setup)
			require("which-key").register(opts.mappings, opts.opts)
		end,
	},
	{
		"numToStr/Comment.nvim",
		keys = {
			{ mode = "n", "<C-/>", "<Plug>(comment_toggle_linewise_current)", desc = "Toggle Comment" },
			{ mode = "i", "<C-/>", "<esc><Plug>(comment_toggle_linewise_current)", desc = "Toggle Comment(Insert)" },
			{ mode = "v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", desc = "Toggle Comment(Visual)" },
		},
		dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		init = function()
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "BufReadPost",
		cmd = "TodoTelescope",
		opts = { signs = false },
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		opts = function()
			return require("tevim.plugins.configs.telescope")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		ft = { "gitcommit", "diff" },
		init = function()
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.jobstart({ "git", "-C", vim.loop.cwd(), "rev-parse" }, {
						on_exit = function(_, return_code)
							if return_code == 0 then
								vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
								vim.schedule(function()
									require("lazy").load({ plugins = { "gitsigns.nvim" } })
								end)
							end
						end,
					})
				end,
				desc = "Load gitsigns only if git repository",
			})
		end,
		opts = function()
			return require("tevim.plugins.configs.gitsign")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufRead",
		opts = function()
			vim.defer_fn(function()
				require("colorizer").attach_to_buffer(0)
			end, 0)
			return require("colorizer").setup()
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{
				mode = { "n", "t" },
				[[<C-`>]],
				"<cmd>ToggleTerm size=10 direction=horizontal<cr>",
				{ desc = "Toggle Terminal" },
			},
		},
		version = "*",
		opts = {
			shading_factor = 0.2,
			highlights = { NormalFloat = { link = "NormalFloat" } },
			float_opts = { border = "none" },
		},
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = { filetypes_denylist = { "neo-tree", "Trouble", "DressingSelect", "TelescopePrompt" } },
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"luukvbaal/statuscol.nvim",
				dependencies = "kevinhwang91/promise-async",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						ft_ignore = { "neo-tree", "Outline" },
						segments = {
							{ sign = { namespace = { "diagnostic*" } } },
							{ sign = { namespace = { "gitsign" } }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, "  " }, click = "v:lua.ScLa" },
							{ text = { builtin.foldfunc, "  " }, click = "v:lua.ScFa" },
						},
					})
				end,
			},
		},
		init = function()
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
		end,
		config = function()
			require("ufo").setup({
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			})
		end,
	},

	--------------------------------------------------------------
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("tevim.plugins.configs.luasnips").luasnip(opts)
				end,
			},
			{
				"windwp/nvim-autopairs",
				event = "InsertEnter",
				opts = function()
					require("nvim-autopairs").setup({ fast_wrap = {}, disable_filetype = { "TelescopePrompt", "vim" } })
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
		},
		opts = function()
			return require("tevim.plugins.configs.cmp")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall", "LspStart" },
		dependencies = {
			{
				"nvimdev/lspsaga.nvim",
				opts = { symbol_in_winbar = { show_file = false } },
			},
			{
				"williamboman/mason.nvim",
				cmd = { "Mason", "MasonInstall", "MasonUpdate" },
				opts = function()
					return require("tevim.plugins.configs.mason")
				end,
			},
			{
				"ray-x/lsp_signature.nvim",
				opts = { hint_enable = false },
			},
		},
		config = function()
			require("tevim.plugins.configs.lspconfig")
		end,
	},
}

local check, _ = pcall(require, "custom")
if check then
	require("custom")
	local custom_plugins = require("custom.plugins")
	if #custom_plugins > 0 then
		for _, plugin in ipairs(custom_plugins) do
			table.insert(plugins, plugin)
		end
	end
else
	vim.cmd("TeVimCreateCustom")
end

require("lazy").setup(plugins, {
	defaults = { lazy = true },
	ui = {
		icons = {
			ft = "",
			lazy = "󰂠 ",
			loaded = "",
			not_loaded = "",
		},
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
})
