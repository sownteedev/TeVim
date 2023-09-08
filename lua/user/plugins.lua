local plugins = {
	-- Plugin manager
	["wbthomason/packer.nvim"] = {},

	-- Impatient optimize the startup time
	["lewis6991/impatient.nvim"] = {
		config = function()
			require("impatient").enable_profile()
		end
	},
	["nvim-lua/plenary.nvim"] = {},

	-- File explorer
	["nvim-neo-tree/neo-tree.nvim"] = {
		cmd = "Neotree",
		branch = "v2.x",
		config = function()
			require("ui.neotree")
		end
	},

	-- Icons
	["kyazdani42/nvim-web-devicons"] = {
		config = function()
			require("plugins.devicons")
		end
	},

	-- Perfect layout
	["folke/edgy.nvim"] = {
		config = function()
			require("ui.edgy")
		end
	},

	-- Buffer
	["akinsho/bufferline.nvim"] = {
		tag = "*",
		event = "BufRead",
		config = function()
			require("ui.bufferline")
		end
	},

	-- Statusline
	["nvim-lualine/lualine.nvim"] = {
		config = function()
			require("ui.lualine")
		end
	},

	-- Treesitter
	["nvim-treesitter/nvim-treesitter"] = {
		run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
		requires = { "nvim-treesitter/nvim-treesitter-context" },
		config = function()
			require("plugins.treesitter")
		end
	},
	["windwp/nvim-ts-autotag"] = { event = "InsertEnter" },

	-- Auto closing
	["windwp/nvim-autopairs"] = {
		event = "InsertEnter",
		config = function()
			require("plugins.cmp.autopairs")
		end
	},

	-- Surround words with: "({[
	["kylechui/nvim-surround"] = {
		event = { "BufReadPost", "BufNewFile" },
		tag = "*",
		config = function()
			require("nvim-surround").setup()
		end
	},

	-- Whichkey
	["folke/which-key.nvim"] = {
		config = function()
			require("plugins.whichkey")
		end
	},

	-- Comment
	["numToStr/Comment.nvim"] = {
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("Comment").setup()
		end
	},

	-- Telescope, Fzfinder
	["nvim-telescope/telescope.nvim"] = {
		branch = '0.1.x',
		config = function()
			require("plugins.telescope")
		end
	},

	-- Support README.md
	["iamcco/markdown-preview.nvim"] = {
		ft = "markdown",
		run = function()
			vim.fn["mkdp#util#install"]()
		end
	},

	-- Git
	["lewis6991/gitsigns.nvim"] = {
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.gitsigns")
		end
	},

	-- Color
	["NvChad/nvim-colorizer.lua"] = {
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("plugins.colorize")
		end
	},

	-- UI
	["stevearc/dressing.nvim"] = {
		config = function()
			require("dressing").setup()
		end
	},

	-- Trouble
	["folke/trouble.nvim"] = {},

	-- UI CMD
	["folke/noice.nvim"] = {
		requires = { "MunifTanjim/nui.nvim" },
		config = function()
			require("plugins.noice")
		end
	},

	-- Notification
	["rcarriga/nvim-notify"] = {},

	-- Terminal
	["akinsho/toggleterm.nvim"] = {
		tag = '*',
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-\>]],
				shading_factor = 2,
			})
		end
	},

	-- Discord Show
	["andweeb/presence.nvim"] = {
		config = function()
			require("presence").setup {
				neovim_image_text = "Coding by @SownteeNguyen",
				main_image = "file", -- neovim
			}
		end
	},

	-- Outline
	["simrat39/symbols-outline.nvim"] = {
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("symbols-outline").setup()
		end
	},

	-- Auto highlight same systax
	["RRethy/vim-illuminate"] = {
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("illuminate").configure {
				filetypes_denylist = { "alpha", "NvimTree", "neo-tree", "packer", "Trouble", "DressingSelect",
					"TelescopePrompt" },
			}
		end
	},

	-- Scrollbar
	["lewis6991/satellite.nvim"] = {
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("satellite").setup({
				excluded_filetypes = { "neo-tree" },
				handlers = {
					cursor = { symbols = { ' ', ' ', ' ', ' ' } },
					gitsigns = { signs = { add = "", change = "", delete = "" } },
					diagnostic = { signs = { '', '', '' } },
				},
			})
		end
	},

	-- TODO
	["folke/todo-comments.nvim"] = {
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("todo-comments").setup()
		end
	},

	-- Better statuscol
	["luukvbaal/statuscol.nvim"] = {
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				ft_ignore = { "neo-tree", "NvimTree", "Outline" },
				segments = {
					{ text = { " ", builtin.foldfunc, "  " }, click = "v:lua.ScFa" },
					{
						sign = { name = { "Diagnostic" }, maxwidth = 1, auto = false },
						click = "v:lua.ScFa",
					},
					{ text = { builtin.lnumfunc, " " },       click = "v:lua.ScLa" },
					{
						sign = { name = { "GitSigns" }, maxwidth = 1, auto = false },
						click = "v:lua.ScSa",
					},
					{ text = { " " } }
				},
			})
		end
	},

	-- Neovim's fold
	["kevinhwang91/nvim-ufo"] = {
		event = { "BufReadPost", "BufNewFile" },
		requires = { "kevinhwang91/promise-async" },
		config = function()
			require("ufo").setup({
				provider_selector = function()
					return { 'treesitter', 'indent' }
				end,
			})
		end
	},

	-- Debug
	["mfussenegger/nvim-dap"] = {},
	["rcarriga/nvim-dap-ui"] = {},

	----------------------------------------------------------------------------

	-- Neodev
	["folke/neodev.nvim"] = {
		config = function()
			require("neodev").setup()
		end
	},

	-- Auto completions
	["hrsh7th/nvim-cmp"] = {
		requires = {
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

	-- AI
	["zbirenbaum/copilot-cmp"] = {
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end
	},
	["zbirenbaum/copilot.lua"] = {
		config = function()
			require("copilot").setup()
		end
	},

	-- Snippets
	["L3MON4D3/LuaSnip"] = {},
	["saadparwaiz1/cmp_luasnip"] = {},
	["rafamadriz/friendly-snippets"] = {},

	-- Manage and Install LSP
	["williamboman/mason.nvim"] = {
		config = function()
			require("plugins.lsp.mason")
		end
	},
	["williamboman/mason-lspconfig"] = {
		config = function()
			require("plugins.lsp.mason")
		end
	},
	["jayp0521/mason-null-ls.nvim"] = {
		config = function()
			require("plugins.lsp.mason")
		end
	},

	-- Config for LSP Servers
	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.lsp.lspconfig")
		end
	},
	["nvimdev/lspsaga.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("plugins.lsp.lspsaga")
		end
	},
	["ray-x/lsp_signature.nvim"] = { event = "InsertEnter" },
	["onsails/lspkind.nvim"] = {},
	["SmiteshP/nvim-navic"] = {
		config = function()
			require("plugins.cmp.navic")
		end
	},

	-- Formatting
	["jose-elias-alvarez/null-ls.nvim"] = {
		config = function()
			require("plugins.lsp.null-ls")
		end
	},
}

----------------------------------------------------------------------------------------------------

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP =
		vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.api.nvim_command("packadd packer.nvim")
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "none" })
		end,
	},
})

packer.startup({
	function(use)
		for key, plugin in pairs(plugins) do
			if type(key) == "string" and not plugin[1] then
				plugin[1] = key
			end
			use(plugin)
		end
		if PACKER_BOOTSTRAP then
			require("packer").sync()
		end
	end,
	config = {
		display              = {
			open_fn         = function()
				return require("packer.util").float({ border = "none" })
			end,
			non_interactive = false,
			compact         = false,
			open_cmd        = '65vnew \\[packer\\]',
			working_sym     = '󰁇 ',
			error_sym       = ' ',
			done_sym        = ' ',
			removed_sym     = ' ',
			moved_sym       = '󰪹 ',
			header_sym      = '━ ',
			show_all_info   = true,
			prompt_border   = 'double',
			keybindings     = {
				quit = 'q',
				toggle_update = 'u',
				continue = 'c',
				toggle_info = '<CR>',
				diff = 'd',
				prompt_revert = 'r',
			}
		},
		profile              = {
			enable = true,
			threshold = 0.0001,
		},
		git                  = {
			clone_timeout = 60,
			depth = 1,
			cmd = 'git',
			subcommands = {
				update = "pull --rebase",
			},
		},
		auto_clean           = true,
		compile_on_sync      = true,
		ensure_dependencies  = true,
		snapshot             = nil,
		plugin_package       = 'packer',
		max_jobs             = nil,
		disable_commands     = false,
		opt_default          = false,
		transitive_opt       = true,
		transitive_disable   = true,
		auto_reload_compiled = true,
		preview_updates      = false,
		autoremove           = false,
	},
})
