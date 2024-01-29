local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

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

autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		vim.diagnostic.open_float({ scope = "cursor", focusable = false })
	end,
	desc = "Open Float Window for LSP Diagnostics",
})

autocmd("TextYankPost", {
	group = augroup("yank_highlight", {}),
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
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
	desc = "Don't list quickfix buffer",
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
	vim.cmd("lua require('tevim.user.utils').CreateCustom()")
end, {})
