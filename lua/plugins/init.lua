return {
	"nvim-lua/plenary.nvim",
	"nvim-lua/popup.nvim",
	"MunifTanjim/nui.nvim",
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		branch = "v3.x",
		config = function()
			require("ui.neotree")
		end

	},
	{
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.others.devicons")
		end
	},
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		config = function()
			require("ui.edgy")
		end
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
		dependencies = { "nvim-treesitter/nvim-treesitter-context", "HiPhish/rainbow-delimiters.nvim",
			"windwp/nvim-ts-autotag" },
		config = function()
			require("plugins.others.treesitter")
		end
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
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
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
		event = { "BufReadPre", "BufNewFile" },
		lazy = true,
		config = function()
			require("plugins.others.gitsigns")
		end
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("plugins.others.colorize")
		end
	},
	"stevearc/dressing.nvim",
	{
		"folke/noice.nvim",
		config = function()
			require("plugins.others.noice")
		end
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({ shading_factor = 2 })
		end
	},
	{
		"andweeb/presence.nvim",
		config = function()
			require("presence").setup {
				neovim_image_text = "Coding by @SownteeNguyen",
				main_image = "file", -- neovim
			}
		end
	},
	{
		"simrat39/symbols-outline.nvim",
		event = { "BufReadPost", "BufNewFile" },
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
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("todo-comments").setup()
		end
	},
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				ft_ignore = { "neo-tree", "NvimTree", "Outline" },
				segments = {
					{ text = { " ", builtin.foldfunc, "  " },                         click = "v:lua.ScFa" },
					{ sign = { name = { "Diagnostic" }, maxwidth = 1, auto = false }, click = "v:lua.ScFa" },
					{ text = { builtin.lnumfunc, " " },                               click = "v:lua.ScLa" },
					{ sign = { name = { "GitSigns" }, maxwidth = 1, auto = false },   click = "v:lua.ScSa" },
				},
			})
		end
	},
	{
		"kevinhwang91/nvim-ufo",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "kevinhwang91/promise-async" },
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
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
		},
		config = function()
			require("plugins.cmp.cmp")
		end
	},
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_no_tab_map = true;
			vim.g.copilot_assume_mapped = true;
			vim.g.copilot_tab_fallback = "";
		end
	},
	{
		"jcdickinson/codeium.nvim",
		config = function()
			require("codeium").setup()
		end
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
		version = "2.*",
		build = "make install_jsregexp"
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig",
			"jayp0521/mason-null-ls.nvim"
		},
		config = function()
			require("plugins.lsp.mason")
		end
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvimdev/lspsaga.nvim",
			config = function()
				require("plugins.lsp.lspsaga")
			end
		},
		config = function()
			require("plugins.lsp.lspconfig")
		end
	},
	"onsails/lspkind.nvim",
	{
		"SmiteshP/nvim-navic",
		config = function()
			require("nvim-navic").setup({ lsp = { auto_attach = true } })
		end
	},
	"folke/trouble.nvim",
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("plugins.lsp.null-ls")
		end
	}
}
