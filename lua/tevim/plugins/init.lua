return {
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = function() require("tevim.plugins.others.devicons") end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		branch = "v3.x",
		config = function() require("tevim.plugins.others.neotree") end
	},
	{
		"nvim-treesitter/nvim-treesitter",
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		lazy = true,
		build = ":TSUpdate",
		dependencies = { "nvim-treesitter/nvim-treesitter-context", "HiPhish/rainbow-delimiters.nvim" },
		config = function() require("tevim.plugins.others.treesitter") end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
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
		event = "InsertEnter",
		lazy = true,
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function() require("tevim.plugins.others.whichkey") end
	},
	{
		"numToStr/Comment.nvim",
		event = "BufReadPost",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
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
		dependencies = {
			{
				"ahmedkhalf/project.nvim",
				config = function() require("project_nvim").setup() end
			},
		},
		branch = '0.1.x',
		config = function() require("tevim.plugins.others.telescope") end
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function() vim.fn["mkdp#util#install"]() end
	},
	{
		"andweeb/presence.nvim",
		event = "BufReadPost",
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
		ft = { "gitcommit", "diff" },
		init = function()
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.jobstart({ "git", "-C", vim.loop.cwd(), "rev-parse" },
						{
							on_exit = function(_, return_code)
								if return_code == 0 then
									vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
									vim.schedule(function()
										require("lazy").load { plugins = { "gitsigns.nvim" } }
									end)
								end
							end
						}
					)
				end,
			})
		end,
		commit = "7f6f1565ac0d9f4e26d87135c6cbe0b9fdcf70b3",
		config = function() require("tevim.plugins.others.gitsigns") end
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufRead",
		lazy = true,
		config = function() require("tevim.plugins.others.colorize") end
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
		"kevinhwang91/nvim-ufo",
		event = "BufReadPost",
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
		lazy = true,
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				lazy = true,
				version = "2.*",
				build = "make install_jsregexp"
			},
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)
					local cmp_autopairs = require "nvim-autopairs.completion.cmp"
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
			{
				"jcdickinson/codeium.nvim",
				event = "InsertEnter",
				config = function() require("codeium").setup() end
			},
		},
		config = function() require("tevim.plugins.cmp.cmp") end
	},
	{
		"github/copilot.vim",
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		lazy = true,
		dependencies = {
			{
				"nvimdev/lspsaga.nvim",
				event = "LspAttach",
				config = function() require("tevim.plugins.lsp.lspsaga") end
			},
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function() require("tevim.plugins.lsp.null-ls") end
			},
			{
				"williamboman/mason.nvim",
				cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
				lazy = true,
				config = function() require("tevim.plugins.lsp.mason") end
			},
			{
				"ray-x/lsp_signature.nvim",
				opts = { hint_enable = false },
				config = function(_, opts) require("lsp_signature").setup(opts) end
			}
		},
		config = function() require("tevim.plugins.lsp.lspconfig") end
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		lazy = true,
	},
	{
		"xeluxee/competitest.nvim",
		event = "BufRead",
		dependencies = "MunifTanjim/nui.nvim",
		config = function() require("tevim.plugins.others.competitest") end,
	},
}
