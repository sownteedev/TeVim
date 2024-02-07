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

autocmd({ "FileType" }, {
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

autocmd({ "UIEnter" }, {
	callback = function()
		require("tevim.themes").load()
	end,
	desc = "Load TeVim Themes",
})

autocmd({ "FileType", "BufNewFile" }, {
	pattern = "*",
	callback = function()
		require("tevim.ui.testtline").setup()
	end,
	desc = "Load TeStatusline",
})

autocmd({ "BufNewFile", "BufReadPost" }, {
	callback = function()
		require("tevim.ui.tebufline").setup()
	end,
	desc = "Load TeBufline",
})

if vim.g.load_tedash_on_startup then
	autocmd({ "UIEnter" }, {
		callback = function()
			local should_skip = false
			if vim.fn.argc() > 0 or vim.fn.line2byte("$") ~= -1 or not vim.o.modifiable then
				should_skip = true
			else
				for _, arg in pairs(vim.v.argv) do
					if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
						should_skip = true
						break
					end
				end
			end
			if not should_skip then
				require("tevim.ui.tedash").setup()
			end
		end,
		desc = "Load TeDash",
	})
end

autocmd("VimResized", {
	callback = function()
		if vim.bo.filetype == "tedash" then
			vim.opt_local.modifiable = true
			vim.api.nvim_buf_set_lines(0, 0, -1, false, { "" })
			require("tevim.ui.tedash").setup()
		end
	end,
	desc = "Resize Dashboard",
})

autocmd("BufWritePost", {
	pattern = "*/lua/*",
	callback = function(opts)
		local fp = vim.fn.fnamemodify(vim.fs.normalize(vim.api.nvim_buf_get_name(opts.buf)), ":r")
		local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
		local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")
		vim.cmd("silent source %")

		require("plenary.reload").reload_module("tevim.themes")
		require("plenary.reload").reload_module(module)
		require("plenary.reload").reload_module("custom")

		require("plenary.reload").reload_module("tevim.ui.tebufline")
		vim.opt.tabline = "%!v:lua.require('tevim.ui.tebufline').getTabline()"

		require("plenary.reload").reload_module("tevim.ui.testtline")
		vim.opt.statusline = "%!v:lua.require('tevim.ui.testtline').setup()"

		require("tevim.themes").load()
	end,
	desc = "Reload neovim config on save",
})

-- Create custom command to Create Custom Config
vim.api.nvim_create_user_command("TeVimCreateCustom", function()
	vim.cmd("lua require('tevim.core.utils').CreateCustom()")
end, {})
vim.api.nvim_create_user_command("TeVimCheckMason", function()
	vim.cmd("lua require('tevim.core.utils').checkMason()")
end, {})
