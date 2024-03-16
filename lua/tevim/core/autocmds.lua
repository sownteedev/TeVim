local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local is_available = require("tevim.core.utils").is_available

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
		vim.opt_local.number = false
		vim.opt_local.cursorline = false
		vim.opt_local.foldcolumn = "0"
		vim.opt_local.signcolumn = "no"
		vim.cmd("startinsert")
	end,
	desc = "Disable number and cursorline in terminal",
})

autocmd("FileType", {
	pattern = {
		"neo-tree",
		"PlenaryTestPopup",
		"checkhealth",
		"fugitive",
		"git",
		"gitcommit",
		"help",
		"lazy",
		"lazyterm",
		"lspinfo",
		"man",
		"mason",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"Trouble",
		"trouble",
		"toggleterm",
	},
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.cursorline = false
		vim.b.miniindentscope_disable = true
	end,
	desc = "Disable miniindentscope, number and cursorline in specific filetypes",
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

autocmd("FileType", {
	group = augroup("unlist_quickfist", { clear = true }),
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
	desc = "Don't list quickfix buffer",
})

autocmd({ "BufNewFile", "BufRead" }, {
	callback = function()
		if vim.g.loadTeBufLine then
			require("tevim.ui.tebufline").setup()
		end
	end,
})
autocmd("UIEnter", {
	callback = function()
		if vim.g.loadTeVimTheme then
			dofile(vim.g.themeCache .. "allThemes")
		end
		if vim.g.loadTeStatusLine then
			vim.opt.statusline = "%!v:lua.require('tevim.ui.testatusline').setup()"
		end
		local buf_lines = vim.api.nvim_buf_get_lines(0, 0, 1, false)
		local no_buf_content = vim.api.nvim_buf_line_count(0) == 1 and buf_lines[1] == ""
		local bufname = vim.api.nvim_buf_get_name(0)
		if bufname == "" and no_buf_content then
			require("tevim.ui.tedash").setup()
		end
	end,
})

autocmd("BufWritePost", {
	pattern = vim.fn.stdpath("config") .. "/lua/*.lua",
	group = augroup("TeVimReload", { clear = true }),
	callback = function(opts)
		local fp = vim.fn.fnamemodify(vim.fs.normalize(vim.api.nvim_buf_get_name(opts.buf)), ":r")
		local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
		local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")
		vim.cmd("silent source %")
		if vim.g.loadTeVimTheme then
			require("plenary.reload").reload_module("tevim.themes")
		end
		require("plenary.reload").reload_module(module)
		require("plenary.reload").reload_module("custom")

		if vim.g.loadTeBufLine then
			require("plenary.reload").reload_module("tevim.ui.tebufline")
			vim.opt.tabline = "%!v:lua.require('tevim.ui.tebufline').getTabline()"
		end
		if vim.g.loadTeStatusLine then
			require("plenary.reload").reload_module("tevim.ui.testatusline")
			vim.opt.statusline = "%!v:lua.require('tevim.ui.testatusline').setup()"
		end
		if vim.g.loadTeVimTheme then
			require("tevim.themes").load()
		end
	end,
	desc = "Reload neovim config on save",
})

-- Create custom command
vim.api.nvim_create_user_command("TeVimUpdate", function()
	require("tevim.core.utils").TeVimUpdate()
end, {})
vim.api.nvim_create_user_command("TeVimCreateCustom", function()
	require("tevim.core.utils").CreateCustom()
end, {})
vim.api.nvim_create_user_command("TeVimCheckMason", function()
	require("tevim.core.utils").checkMason()
end, {})
vim.api.nvim_create_user_command("TeVimThemes", function()
	require("tevim.themes.pick").setup()
end, {})
vim.api.nvim_create_user_command("TeVimToggleTrans", function()
	require("tevim.themes.pick").toggleTransparency()
end, {})
vim.api.nvim_create_user_command("LazyGit", function()
	require("tevim.core.utils").LazyGit()
end, {})
vim.api.nvim_create_user_command("Ranger", function()
	require("tevim.core.utils").Ranger()
end, {})
