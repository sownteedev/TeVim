local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local is_available = require("tevim.core.utils").is_available
local core_group = augroup("tevim_core_autocmds", { clear = true })

autocmd("BufWritePre", {
	group = augroup("create_dir", { clear = true }),
	callback = function(args)
		if args.match:match("^%w%w+://") then
			return
		end
		vim.fn.mkdir(vim.fn.fnamemodify(vim.uv.fs_realpath(args.match) or args.match, ":p:h"), "p")
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
				local stats = vim.uv.fs_stat(vim.api.nvim_buf_get_name(0))
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
	group = core_group,
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
	group = core_group,
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

local auxiliary_filetypes = {
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
}

local function clear_neotree_winbars()
	if vim.go.winbar ~= "" then
		vim.go.winbar = ""
	end
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_is_valid(win) then
			local buf = vim.api.nvim_win_get_buf(win)
			if vim.bo[buf].filetype == "neo-tree" and vim.wo[win].winbar ~= "" then
				vim.wo[win].winbar = ""
			end
		end
	end
end

local function schedule_neotree_winbar_cleanup()
	clear_neotree_winbars()
	vim.schedule(clear_neotree_winbars)
end

autocmd("FileType", {
	group = core_group,
	pattern = auxiliary_filetypes,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.cursorline = false
		vim.opt_local.foldcolumn = "0"
		vim.opt_local.signcolumn = "no"
		vim.b.miniindentscope_disable = true
		vim.opt_local.statuscolumn = ""
		if vim.bo.filetype == "neo-tree" then
			vim.opt_local.winbar = ""
		end
	end,
	desc = "Simplify editor columns in auxiliary filetypes",
})

autocmd({ "BufWinEnter", "WinEnter" }, {
	group = core_group,
	callback = function(args)
		if vim.bo[args.buf].filetype == "neo-tree" then
			schedule_neotree_winbar_cleanup()
		end
	end,
	desc = "Keep inherited LSP winbars out of Neo-tree",
})

autocmd("User", {
	group = core_group,
	pattern = "SagaSymbolUpdate",
	callback = schedule_neotree_winbar_cleanup,
	desc = "Clear delayed lspsaga winbars from Neo-tree",
})

autocmd("LspAttach", {
	group = core_group,
	callback = schedule_neotree_winbar_cleanup,
	desc = "Prevent LSP winbars from leaking into Neo-tree",
})

autocmd("OptionSet", {
	group = core_group,
	pattern = "winbar",
	callback = function()
		if vim.bo.filetype == "neo-tree" and vim.wo.winbar ~= "" then
			schedule_neotree_winbar_cleanup()
		end
	end,
	desc = "Reject winbars added to Neo-tree by other plugins",
})

schedule_neotree_winbar_cleanup()

autocmd("FileType", {
	group = core_group,
	pattern = "*",
	callback = function()
		if vim.bo.buftype == "" and not vim.tbl_contains(auxiliary_filetypes, vim.bo.filetype) then
			vim.opt_local.foldcolumn = "1"
		end
	end,
	desc = "Show the fold column only in regular file buffers",
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
	group = core_group,
	callback = function()
		if vim.g.loadTeBufLine then
			require("tevim.ui.tebufline").setup()
		end
	end,
})
autocmd("UIEnter", {
	group = core_group,
	callback = function()
		if vim.g.loadTeVimTheme then
			require("tevim.themes").load()
		end
		if vim.g.loadTeBufLine then
			vim.o.tabline = '%!v:lua.require("tevim.ui.tebufline").getTabline()'
		end
		if vim.g.loadTeStatusLine then
			require("tevim.ui.testatusline").setup()
		end
		local buf_lines = vim.api.nvim_buf_get_lines(0, 0, 1, false)
		local no_buf_content = vim.api.nvim_buf_line_count(0) == 1 and buf_lines[1] == ""
		local bufname = vim.api.nvim_buf_get_name(0)
		if bufname == "" and no_buf_content then
			require("tevim.ui.tedash").setup()
		end
	end,
})

autocmd("User", {
	pattern = "VeryLazy",
	group = augroup("tevim_theme_final_apply", { clear = true }),
	callback = function()
		if vim.g.loadTeVimTheme then
			require("tevim.themes").load()
		end
	end,
	desc = "Reapply TeVim highlights after startup plugins finish loading",
})

local reload_pending = false
autocmd("BufWritePost", {
	pattern = {
		vim.fn.stdpath("config") .. "/lua/*.lua",
		vim.fn.stdpath("config") .. "/lua/**/*.lua",
	},
	group = augroup("TeVimReload", { clear = true }),
	callback = function(opts)
		if reload_pending then
			return
		end
		reload_pending = true
		local path = vim.fs.normalize(vim.api.nvim_buf_get_name(opts.buf))

		vim.defer_fn(function()
			reload_pending = false
			local lua_root = vim.fs.normalize(vim.fn.stdpath("config") .. "/lua") .. "/"
			local module = path:sub(#lua_root + 1):gsub("%.lua$", ""):gsub("/", ".")

			if module == "tevim.plugins.init" or module == "custom.plugins" then
				vim.notify("Plugin specs changed; run :Lazy reload or restart Neovim", vim.log.levels.INFO)
				return
			end

			local reload = require("plenary.reload").reload_module
			reload(module)
			local ok, err = pcall(require, module)
			if not ok then
				vim.notify(("Failed to reload %s:\n%s"):format(module, err), vim.log.levels.ERROR)
				return
			end

			if vim.g.loadTeBufLine then
				reload("tevim.ui.tebufline")
				vim.opt.tabline = "%!v:lua.require('tevim.ui.tebufline').getTabline()"
			end
			if vim.g.loadTeStatusLine then
				reload("tevim.ui.testatusline")
				require("tevim.ui.testatusline").setup()
			end
			if vim.g.loadTeVimTheme then
				require("tevim.themes").load()
			end
			vim.cmd.redraw()
		end, 50)
	end,
	desc = "Reload neovim config on save",
})

-- Create custom command
local function user_command(name, callback)
	pcall(vim.api.nvim_del_user_command, name)
	vim.api.nvim_create_user_command(name, callback, {})
end

user_command("TeVimUpdate", function()
	require("tevim.core.utils").TeVimUpdate()
end)
user_command("TeVimCreateCustom", function()
	require("tevim.core.utils").CreateCustom()
end)
user_command("TeVimCheckMason", function()
	require("tevim.core.utils").checkMason()
end)
user_command("TeVimThemes", function()
	require("tevim.themes.pick").setup()
end)
user_command("TeVimToggleTrans", function()
	require("tevim.themes.pick").toggleTransparency()
end)
user_command("LazyGit", function()
	require("tevim.core.utils").LazyGit()
end)
user_command("Ranger", function()
	require("tevim.core.utils").Ranger()
end)
