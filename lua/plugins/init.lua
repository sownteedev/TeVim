return {
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		branch = "v3.x",
		config = function()
			require("plugins.others.neotree")
		end
	},
	{
		"kyazdani42/nvim-web-devicons",
		lazy = true,
		config = function()
			require("plugins.others.devicons")
		end,
	},
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.others.edgy")
		end
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
		dependencies = { "nvim-treesitter/nvim-treesitter-context", "HiPhish/rainbow-delimiters.nvim" },
		config = function()
			require("plugins.others.treesitter")
		end
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter"
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		lazy = true,
		config = function()
			require("plugins.cmp.autopairs")
		end
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.others.whichkey")
		end
	},
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("Comment").setup()
		end
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		lazy = true,
		tag = '0.1.3',
		dependencies = { "nvim-telescope/telescope-media-files.nvim" },
		config = function()
			require("plugins.others.telescope")
		end
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = { "BufRead" },
		config = function()
			require("plugins.others.gitsigns")
		end
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = 'BufRead',
		config = function()
			require("plugins.others.colorize")
		end
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	{
		"folke/noice.nvim",
		dependencies = "MunifTanjim/nui.nvim",
		config = function()
			require("plugins.others.noice")
		end
	},
	{
		"akinsho/toggleterm.nvim",
		cmd = "ToggleTerm",
		lazy = true,
		version = "*",
		config = function()
			require("toggleterm").setup({ shading_factor = 2 })
		end
	},
	{
		"andweeb/presence.nvim",
		enabled = false,
		event = "BufRead",
		lazy = true,
		config = function()
			require("presence").setup {
				neovim_image_text = "Coding by @SownteeNguyen",
				main_image = "file", -- neovim
			}
		end
	},
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		lazy = true,
		config = function()
			require("symbols-outline").setup()
		end
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("illuminate").configure {
				filetypes_denylist = { "neo-tree", "Trouble", "DressingSelect", "TelescopePrompt" } }
		end
	},
	{
		"lewis6991/satellite.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("satellite").setup({
				excluded_filetypes = { "neo-tree", "Outline" },
				handlers = {
					gitsigns = { enable = false },
					diagnostic = { enable = false },
				},
			})
		end
	},
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "InsertEnter" },
		opts = { signs = false }
	},
	{
		"luukvbaal/statuscol.nvim",
		event = "BufRead",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				ft_ignore = { "neo-tree", "NvimTree", "Outline" },
				segments = {
					{ text = { " ", builtin.foldfunc, "  " }, click = "v:lua.ScFa" },
					{ sign = { name = { "Diagnostic" } },     click = "v:lua.ScFa" },
					{ text = { builtin.lnumfunc, " " },       click = "v:lua.ScLa" },
					{ sign = { name = { "GitSigns" } },       click = "v:lua.ScSa" },
				},
			})
		end
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "BufReadPost",
		lazy = true,
		dependencies = "kevinhwang91/promise-async",
		config = function()
			require("ufo").setup({
				ignore_filetypes = { "Outline", "neo-tree", "Trouble" },
				provider_selector = function()
					return { 'treesitter', 'indent' }
				end,
			})
		end
	},
	--------------------------------------------------------------
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdwinEnter" },
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			{
				"jcdickinson/codeium.nvim",
				config = function()
					require("codeium").setup()
				end
			},
			{
				"onsails/lspkind.nvim",
				event = "InsertEnter",
				lazy = true,
			},
		},
		config = function()
			require("plugins.cmp.cmp")
		end
	},
	{
		"github/copilot.vim",
		event = "InsertEnter"
	},
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		lazy = true,
		dependencies = "rafamadriz/friendly-snippets",
		version = "2.*",
		build = "make install_jsregexp"
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		lazy = true,
		cmd = { "LspInfo", "LspInstall", "LspUninstall", "LspStart" },
		dependencies = {
			{
				"nvimdev/lspsaga.nvim",
				config = function()
					require("plugins.lsp.lspsaga")
				end
			},
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("plugins.lsp.null-ls")
				end
			},
			{
				"SmiteshP/nvim-navic",
				config = function()
					require("nvim-navic").setup({ lsp = { auto_attach = true } })
				end
			},
			{
				"williamboman/mason.nvim",
				cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
				config = function()
					require("plugins.lsp.mason")
				end
			}
		},
		config = function()
			require("plugins.lsp.lspconfig")
		end
	},
	{
		"folke/trouble.nvim",
		event = "BufReadPost",
	},

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
}
