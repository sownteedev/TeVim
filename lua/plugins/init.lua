return {
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"kyazdani42/nvim-web-devicons",
		lazy = true,
		config = function() require("plugins.others.devicons") end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		branch = "v3.x",
		config = function() require("plugins.others.neotree") end
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
		dependencies = { "nvim-treesitter/nvim-treesitter-context", "HiPhish/rainbow-delimiters.nvim" },
		config = function() require("plugins.others.treesitter") end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		version = "2.20.8",
		dependencies = {
			{
				"shellRaining/hlchunk.nvim",
				config = function()
					require("hlchunk").setup {
						chunk = { notify = false },
						indent = { enable = false },
						line_num = { enable = false },
						blank = { enable = false }
					}
				end
			},
		},
		config = function()
			require("indent_blankline").setup({
				char = "▏",
				show_first_indent_level = false,
			})
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
		config = function() require("plugins.cmp.autopairs") end
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function() require("plugins.others.whichkey") end
	},
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				config = function() require('ts_context_commentstring').setup() end
			}
		},
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		config = function() require("todo-comments").setup() end
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		lazy = true,
		tag = '0.1.3',
		dependencies = { "nvim-telescope/telescope-media-files.nvim" },
		config = function() require("plugins.others.telescope") end
	},
	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		config = function() require("project_nvim").setup() end
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function() vim.fn["mkdp#util#install"]() end
	},
	{
		"andweeb/presence.nvim",
		event = "VeryLazy",
		config = function()
			require("presence").setup {
				editing_text   = "Coding...",
				reading_text   = "Reading...",
				workspace_text = "Working on repository",
			}
		end
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "BufRead",
		commit = "7f6f1565ac0d9f4e26d87135c6cbe0b9fdcf70b3",
		config = function() require("plugins.others.gitsigns") end
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufRead",
		config = function() require("plugins.others.colorize") end
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = function() require("plugins.others.noice") end
	},
	{
		"akinsho/toggleterm.nvim",
		cmd = "ToggleTerm",
		lazy = true,
		version = "*",
		config = function() require("toggleterm").setup { shading_factor = 2 } end
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("illuminate").configure {
				filetypes_denylist = { "neo-tree", "Trouble", "DressingSelect", "TelescopePrompt" }
			}
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
					diagnostic = { signs = { '', '', '' } },
				},
			})
		end
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "BufRead",
		lazy = true,
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						ft_ignore = { "neo-tree", "Outline" },
						segments = {
							{ sign = { name = { "Diagnostic" } }, click = "v:lua.ScFa" },
							{ sign = { name = { "GitSigns" } },   click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, "  " },  click = "v:lua.ScLa" },
							{ text = { builtin.foldfunc, "  " },  click = "v:lua.ScFa" },
						},
					})
				end
			},
		},
		config = function()
			require("ufo").setup({
				provider_selector = function()
					return { 'treesitter', 'indent' }
				end,
			})
		end
	},
	--------------------------------------------------------------
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				version = "2.*",
				build = "make install_jsregexp"
			},
			{
				"jcdickinson/codeium.nvim",
				config = function() require("codeium").setup() end
			},
			"onsails/lspkind.nvim",
		},
		config = function() require("plugins.cmp.cmp") end
	},
	{
		"github/copilot.vim",
		event = "InsertEnter"
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		lazy = true,
		dependencies = {
			{
				"nvimdev/lspsaga.nvim",
				event = "LspAttach",
				config = function() require("plugins.lsp.lspsaga") end
			},
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function() require("plugins.lsp.null-ls") end
			},
			{
				"williamboman/mason.nvim",
				cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
				config = function() require("plugins.lsp.mason") end
			},
			{
				"ray-x/lsp_signature.nvim",
				event = "VeryLazy",
				opts = { hint_enable = false },
				config = function(_, opts) require("lsp_signature").setup(opts) end
			}
		},
		config = function() require("plugins.lsp.lspconfig") end
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function() require("dapui").setup() end
	},
	{
		"xeluxee/competitest.nvim",
		event = "BufRead",
		dependencies = "MunifTanjim/nui.nvim",
		config = function() require("plugins.others.competitest") end,
	},
}
