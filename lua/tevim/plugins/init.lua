local plugins = {
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
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
		dependencies = { "MunifTanjim/nui.nvim" },
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
		lazy = true,
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		run = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"HiPhish/rainbow-delimiters.nvim",
			"windwp/nvim-ts-autotag",
		},
		opts = function()
			return require("tevim.plugins.others.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("ibl").setup({
				indent = { tab_char = "│" },
				scope = { enabled = false },
			})
		end,
	},
	{
		"folke/which-key.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = function()
			return require("tevim.plugins.others.whichkey")
		end,
		config = function(_, opts)
			require("which-key").setup(opts.setup)
			require("which-key").register(opts.mappings, opts.opts)
			require("which-key").register(opts.vmappings, opts.vopts)
		end,
	},
	{
		"numToStr/Comment.nvim",
		lazy = true,
		event = "BufRead",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		lazy = true,
		event = "VeryLazy",
	},
	{
		"folke/todo-comments.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = "Telescope",
		branch = "0.1.x",
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
			return require("tevim.plugins.others.gitsigns")
		end,
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		lazy = true,
		event = "BufRead",
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
		keys = {
			{
				[[<C-\>]],
				"<cmd>ToggleTerm size=10 direction=horizontal<cr>",
				{ noremap = true, silent = true },
				{ desc = "Toggle Terminal" },
			},
		},
		version = "*",
		config = function()
			require("toggleterm").setup({ shading_factor = 2 })
		end,
	},
	{
		"RRethy/vim-illuminate",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("illuminate").configure({
				filetypes_denylist = { "neo-tree", "Trouble", "DressingSelect", "TelescopePrompt" },
			})
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
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
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("tevim.plugins.cmp.luasnip").luasnip(opts)
				end,
			},
			{
				"windwp/nvim-autopairs",
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
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"nvimdev/lspsaga.nvim",
				config = function()
					require("lspsaga").setup({
						symbol_in_winbar = { show_file = false },
					})
				end,
			},
			{
				"williamboman/mason.nvim",
				cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
				lazy = true,
				opts = function()
					return require("tevim.plugins.lsp.mason")
				end,
				config = function(_, opts)
					require("mason").setup(opts)
					vim.api.nvim_create_user_command("MasonInstallAll", function()
						vim.cmd("MasonInstall lua-language-server stylua")
						if opts.ensure_installed and #opts.ensure_installed > 0 then
							vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
						end
					end, {})
				end,
			},
			{
				"ray-x/lsp_signature.nvim",
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
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = "BufWritePre",
		cmd = "ConformInfo",
		opts = function()
			return require("tevim.plugins.lsp.conform")
		end,
		config = function(_, opts)
			require("conform").setup(opts)
		end,
	},
	{
		"folke/trouble.nvim",
		-- lazy = true,
		cmd = { "TroubleToggle", "Trouble" },
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
	vim.cmd([[echohl WarningMsg]])
	vim.cmd(
		[[echomsg "Custom folder not found. Please use :TeVimCreateCustom to create folder and file then read the docs!"]]
	)
	vim.cmd([[echohl None]])
end

require("lazy").setup(plugins)
