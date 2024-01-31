local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local is_available = require("tevim.core.utils").is_available

autocmd({ "UIEnter" }, {
	callback = function()
		require("tevim.themes").load()
		require("tevim.ui.testtline").setup()
		if vim.fn.argc() == 0 then
			require("tevim.ui.tedash").setup()
		end
	end,
	desc = "Load Statusline, Dashboard and Themes",
})
autocmd({ "BufNewFile", "BufReadPost" }, {
	callback = function()
		require("tevim.ui.tebufline").setup()
	end,
	desc = "Load TabBufline",
})

autocmd("BufWritePre", {
	group = augroup("create_dir", { clear = true }),
	callback = function(args)
		if args.match:match("^%w%w+://") then
			return
		end
		vim.fn.mkdir(vim.fn.fnamemodify(vim.loop.fs_realpath(args.match) or args.match, ":p:h"), "p")
	end,
	desc = "Automatically create parent directories if they don't exist when saving a file",
})

if is_available("neo-tree.nvim") then
	autocmd("BufEnter", {
		group = augroup("neotree_start", { clear = true }),
		callback = function()
			if package.loaded["neo-tree"] then
				vim.api.nvim_del_augroup_by_name("neotree_start")
			else
				local stats = (vim.uv or vim.loop).fs_stat(vim.api.nvim_buf_get_name(0))
				if stats and stats.type == "directory" then
					vim.api.nvim_del_augroup_by_name("neotree_start")
					require("neo-tree")
				end
			end
		end,
		desc = "Open Neo-Tree on startup with directory",
	})
	autocmd("TermClose", {
		pattern = "*lazygit*",
		group = augroup("neotree_refresh", { clear = true }),
		callback = function()
			local manager_avail, manager = pcall(require, "neo-tree.sources.manager")
			if manager_avail then
				for _, source in ipairs({ "filesystem", "git_status", "document_symbols" }) do
					local module = "neo-tree.sources." .. source
					if package.loaded[module] then
						manager.refresh(require(module).name)
					end
				end
			end
		end,
		desc = "Refresh Neo-Tree when closing lazygit",
	})
end

autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		vim.diagnostic.open_float({ scope = "cursor", focusable = false })
	end,
	desc = "Open Float Window for LSP Diagnostics",
})

autocmd("TextYankPost", {
	group = augroup("highlightyank", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Highlight yanked text",
})

autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.opt.number = false
		vim.opt_local.cursorline = false
		vim.opt_local.foldcolumn = "0"
		vim.opt_local.signcolumn = "no"
		vim.cmd("startinsert")
	end,
	desc = "Disable number and cursorline in terminal",
})

autocmd("BufWritePre", {
	callback = function()
		local formatOnSave = require("tevim.plugins.lsp.conform").formatOnSave
		if formatOnSave then
			vim.cmd("lua require('conform').format()")
		end
	end,
	desc = "Format on save",
})

autocmd({ "FileType" }, {
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"fugitive",
		"git",
		"gitcommit",
		"help",
		"lazy",
		"lspinfo",
		"man",
		"mason",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function()
		vim.opt.number = false
		vim.opt_local.cursorline = false
	end,
	desc = "Disable number and cursorline",
})

autocmd("BufWinEnter", {
	group = augroup("q_close_windows", { clear = true }),
	callback = function(args)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
		if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) and vim.fn.maparg("q", "n") == "" then
			vim.keymap.set("n", "q", "<cmd>close<cr>", {
				desc = "Close window",
				buffer = args.buf,
				silent = true,
				nowait = true,
			})
		end
	end,
	desc = "Make q close help, man, quickfix, dap floats",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"alpha",
		"tedash",
		"neo-tree",
		"Trouble",
		"trouble",
		"lazy",
		"mason",
		"notify",
		"toggleterm",
		"lazyterm",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
	desc = "Disable miniindent",
})

autocmd("FileType", {
	group = augroup("unlist_quickfist", { clear = true }),
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
	desc = "Don't list quickfix buffer",
})

-- autocmd("BufWritePost", {
-- 	pattern = "*/lua/*",
-- 	callback = function(opts)
-- 		local fp = vim.fn.fnamemodify(vim.fs.normalize(vim.api.nvim_buf_get_name(opts.buf)), ":r")
-- 		local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
-- 		local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")
-- 		vim.cmd("silent source %")
--
-- 		require("plenary.reload").reload_module("tevim.themes")
-- 		require("plenary.reload").reload_module(module)
-- 		require("plenary.reload").reload_module("custom")
--
-- 		require("plenary.reload").reload_module("tevim.ui.tebufline")
-- 		vim.opt.tabline = "%!v:lua.require('tevim.ui.tebufline').getTabline()"
--
-- 		require("plenary.reload").reload_module("tevim.ui.testtline")
-- 		vim.opt.statusline = "%!v:lua.require('tevim.ui.testtline').setup()"
--
-- 		require("tevim.themes").load()
-- 	end,
-- 	desc = "Reload neovim config on save",
-- })

-- Create custom command to Create Custom Config
vim.api.nvim_create_user_command("TeVimCreateCustom", function()
	vim.cmd("lua require('tevim.core.utils').CreateCustom()")
end, {})
