local plugins = {
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"MunifTanjim/nui.nvim",
		lazy = true,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		event = "BufRead",
		opts = function()
			return require("tevim.plugins.others.devicons")
		end,
		config = function(_, opts)
			require("nvim-web-devicons").set_default_icon("󰈚")
			require("nvim-web-devicons").setup(opts)
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = true,
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
			return require("tevim.plugins.others.neotree")
		end,
		config = function(_, opts)
			require("neo-tree").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		lazy = true,
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSUninstall" },
		build = ":TSUpdate",
		dependencies = "HiPhish/rainbow-delimiters.nvim",
		opts = function()
			return require("tevim.plugins.others.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		lazy = true,
		ft = { "html", "javascript", "jsx", "typescript", "tsx", "svelte", "vue", "xml", "markdown" },
		config = function(_, opts)
			require("nvim-ts-autotag").setup(opts)
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		version = "2.20.7",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"echasnovski/mini.indentscope",
				lazy = true,
				opts = { symbol = "│" },
			},
		},
		opts = function()
			return require("tevim.plugins.others.others").blankline
		end,
		config = function(_, opts)
			require("indent_blankline").setup(opts)
		end,
	},
	{
		"folke/which-key.nvim",
		lazy = true,
		keys = { "<leader>", " ", "'", "`" },
		cmd = "WhichKey",
		opts = function()
			return require("tevim.plugins.others.whichkey")
		end,
		config = function(_, opts)
			require("which-key").setup(opts.setup)
			require("which-key").register(opts.mappings, opts.opts)
		end,
	},
	{
		"numToStr/Comment.nvim",
		lazy = true,
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
		lazy = true,
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
		lazy = true,
		event = "BufReadPost",
		cmd = "TodoTelescope",
		opts = { signs = false },
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = "Telescope",
		opts = function()
			return require("tevim.plugins.others.telescope")
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		lazy = true,
		ft = "markdown",
		build = ":call mkdp#util#install()",
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
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
			return require("tevim.plugins.others.others").gitsigns
		end,
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		lazy = true,
		event = "BufRead",
		opts = {},
		config = function(_, opts)
			require("colorizer").setup(opts)
			vim.defer_fn(function()
				require("colorizer").attach_to_buffer(0)
			end, 0)
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		lazy = true,
		cmd = "ToggleTerm",
		keys = { { [[<C-`>]], "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Toggle Terminal" } } },
		version = "*",
		opts = {
			shading_factor = 0.2,
			highlights = { NormalFloat = { link = "NormalFloat" } },
			float_opts = { border = "none" },
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
		end,
	},
	{
		"RRethy/vim-illuminate",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		opts = { filetypes_denylist = { "neo-tree", "Trouble", "DressingSelect", "TelescopePrompt" } },
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"luukvbaal/statuscol.nvim",
				lazy = true,
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
		lazy = true,
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
				lazy = true,
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("tevim.plugins.cmp.luasnip").luasnip(opts)
				end,
			},
			{
				"windwp/nvim-autopairs",
				lazy = true,
				event = "InsertEnter",
				opts = { fast_wrap = {}, disable_filetype = { "TelescopePrompt", "vim" } },
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
		},
		opts = function()
			return require("tevim.plugins.cmp.cmp")
		end,
		config = function(_, opts)
			require("cmp").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall", "LspStart" },
		dependencies = {
			{
				"nvimdev/lspsaga.nvim",
				lazy = true,
				opts = { symbol_in_winbar = { show_file = false } },
				config = function(_, opts)
					require("lspsaga").setup(opts)
				end,
			},
			{
				"williamboman/mason.nvim",
				cmd = { "Mason", "MasonInstall", "MasonUpdate" },
				lazy = true,
				opts = function()
					return require("tevim.plugins.lsp.mason")
				end,
				config = function(_, opts)
					require("mason").setup(opts)
				end,
			},
			{
				"ray-x/lsp_signature.nvim",
				lazy = true,
				opts = { hint_enable = false },
				config = function(_, opts)
					require("lsp_signature").setup(opts)
				end,
			},
		},
		config = function()
			require("tevim.plugins.lsp.lspconfig")
		end,
	},
}

local custom_path = vim.fn.stdpath("config") .. "/lua/custom"
if vim.loop.fs_stat(custom_path) then
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

require("lazy").setup(plugins)
