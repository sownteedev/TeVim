local plugins = {
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = function()
			require("tevim.plugins.others.devicons")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		keys = { { "<C-e>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" } },
		branch = "v3.x",
		dependencies = { "MunifTanjim/nui.nvim" },
		init = function()
			if vim.fn.argc(-1) == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		config = function()
			require("tevim.plugins.others.neotree")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		lazy = true,
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		dependencies = { "nvim-treesitter/nvim-treesitter-context", "HiPhish/rainbow-delimiters.nvim" },
		opts = function()
			return require("tevim.plugins.others.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		config = function()
			require("ibl").setup({
				indent = { tab_char = "│" },
				scope = { enabled = false },
			})
		end,
		main = "ibl",
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascript", "typescript", "svelte", "vue", "tsx" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"folke/which-key.nvim",
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
		event = "BufReadPost",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		lazy = true,
		dependencies = {
			{
				"ahmedkhalf/project.nvim",
				event = "VeryLazy",
				config = function()
					require("project_nvim").setup()
				end,
			},
		},
		branch = "0.1.x",
		config = function()
			require("tevim.plugins.others.telescope")
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
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
		config = function()
			require("tevim.plugins.others.gitsigns")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufRead",
		lazy = true,
		config = function(_, opts)
			require("colorizer").setup(opts)
			vim.defer_fn(function()
				require("colorizer").attach_to_buffer(0)
			end, 0)
		end,
	},
	{
		"akinsho/toggleterm.nvim",
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
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("illuminate").configure({
				filetypes_denylist = { "neo-tree", "Trouble", "DressingSelect", "TelescopePrompt" },
			})
		end,
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
		event = "InsertEnter",
		lazy = true,
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
					require("tevim.plugins.cmp.luasnip").luasnip(opts)
				end,
				version = "2.*",
				build = "make install_jsregexp",
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
		config = function()
			require("tevim.plugins.cmp.cmp")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		lazy = true,
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
		event = "BufWritePre",
		lazy = true,
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
		cmd = { "TroubleToggle", "Trouble" },
		lazy = true,
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
	vim.cmd([[echomsg "Custom folder not found. Please create folder at ~/.config/nvim/lua/ and read the docs"]])
	vim.cmd([[echohl None]])
end

require("lazy").setup(plugins)
