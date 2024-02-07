local M = {}

function M.is_available(plugin)
	local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
	return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

function M.toggle_option(option)
	local value = not vim.api.nvim_get_option_value(option, {})
	vim.opt[option] = value
	local file = vim.fn.stdpath("config") .. "/lua/custom/options.lua"
	local lines = vim.fn.readfile(file)
	local newlines = {}
	local found = false
	for _, line in ipairs(lines) do
		if line == "vim.opt." .. option .. " = " .. tostring(not value) then
			table.insert(newlines, "vim.opt." .. option .. " = " .. tostring(value))
			found = true
		else
			table.insert(newlines, line)
		end
	end
	if not found then
		table.insert(newlines, "vim.opt." .. option .. " = " .. tostring(value))
	end
	vim.fn.writefile(newlines, file)
	vim.notify(option .. " set to " .. tostring(value))
end

function M.toggle_inlayHint()
	if not M.is_available("nvim-lspconfig") then
		return vim.notify("nvim-lspconfig isn't installed!")
	end
	local inlayHint = require("tevim.plugins.lsp.lspconfig").inlayHint
	if inlayHint then
		require("tevim.plugins.lsp.lspconfig").inlayHint = false
		vim.cmd("LspRestart")
		vim.notify("Inlay hints disabled")
	else
		require("tevim.plugins.lsp.lspconfig").inlayHint = true
		vim.cmd("LspRestart")
		vim.notify("Inlay hints enabled")
	end
end

function M.build_run()
	local filetype = vim.bo.filetype
	if filetype == "c" then
		vim.cmd(
			"TermExec cmd='gcc "
				.. vim.fn.expand("%")
				.. " -o "
				.. vim.fn.expand("%:r")
				.. " && "
				.. vim.fn.expand("%:r")
				.. "'"
		)
	elseif filetype == "cpp" then
		vim.cmd(
			"TermExec cmd='g++ "
				.. vim.fn.expand("%")
				.. " -o "
				.. vim.fn.expand("%:r")
				.. " && "
				.. vim.fn.expand("%:r")
				.. "'"
		)
	elseif filetype == "python" then
		vim.cmd("TermExec cmd='python3 " .. vim.fn.expand("%") .. "'")
	elseif filetype == "javascript" then
		vim.cmd("TermExec cmd='node " .. vim.fn.expand("%") .. "'")
	elseif filetype == "typescript" then
		vim.cmd("TermExec cmd='ts-node " .. vim.fn.expand("%") .. "'")
	elseif filetype == "php" then
		vim.cmd("TermExec cmd='php " .. vim.fn.expand("%") .. "'")
	elseif filetype == "java" then
		vim.cmd("TermExec cmd='javac " .. vim.fn.expand("%") .. " && java " .. vim.fn.expand("%:r") .. "'")
	elseif filetype == "cs" then
		vim.cmd("TermExec cmd='mcs " .. vim.fn.expand("%") .. "'")
	elseif filetype == "rust" then
		vim.cmd("TermExec cmd='cargo run'")
	elseif filetype == "go" then
		vim.cmd("TermExec cmd='go run " .. vim.fn.expand("%") .. "'")
	elseif filetype == "lua" then
		vim.cmd("TermExec cmd='lua " .. vim.fn.expand("%") .. "'")
	elseif filetype == "sh" then
		vim.cmd("TermExec cmd='bash " .. vim.fn.expand("%") .. "'")
	elseif filetype == "dart" then
		vim.cmd("TermExec cmd='dart " .. vim.fn.expand("%") .. "'")
	elseif filetype == "html" then
		vim.cmd("TermExec cmd='live-server " .. vim.fn.expand("%:p:h") .. "'")
	elseif filetype == "markdown" then
		vim.cmd("MarkdownPreview")
	end
end

function M.LazyGit()
	local status_ok, _ = pcall(require, "toggleterm")
	if not status_ok then
		return vim.notify("toggleterm.nvim isn't installed!")
	end
	if vim.fn.executable("lazygit") == 0 then
		return vim.notify("lazygit isn't installed")
	end
	local lazygit = require("toggleterm.terminal").Terminal:new({
		cmd = "lazygit",
		dir = "git_dir",
		direction = "float",
		on_open = function(term)
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		end,
	})
	lazygit:toggle()
end

function M.Ranger()
	local status_ok, _ = pcall(require, "toggleterm")
	if not status_ok then
		return vim.notify("toggleterm.nvim isn't installed!")
	end
	if vim.fn.executable("ranger") == 0 then
		return vim.notify("ranger isn't installed")
	end
	local ranger = require("toggleterm.terminal").Terminal:new({
		cmd = "ranger",
		direction = "float",
		on_open = function(term)
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		end,
	})
	ranger:toggle()
end

M.lazy = function(install_path)
	vim.cmd("redraw")
	vim.api.nvim_echo({ { "Hi there, welcome to TEVIM 󱠡 ", "Bold" } }, true, {})
	local repo = "https://github.com/folke/lazy.nvim.git"
	local output = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repo, install_path })
	assert(vim.v.shell_error == 0, "External call failed with error code: " .. vim.v.shell_error .. "\n" .. output)
	vim.opt.rtp:prepend(install_path)
	require("tevim.plugins")
	vim.cmd("MasonInstall lua-language-server stylua")
	vim.cmd("redraw")
	vim.api.nvim_echo({ { "Wait for everything install. Reopen Neovim!", "Bold" } }, true, {})
end

M.checkMason = function()
	local status_ok, _ = pcall(require, "mason")
	if not status_ok then
		return vim.notify("mason.nvim isn't installed!")
	end
	local mason_packages = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/*", 0, 1)
	local mason_installed = {}
	for _, package in ipairs(mason_packages) do
		table.insert(mason_installed, vim.fn.fnamemodify(package, ":t"))
	end
	local ensure_installed = require("custom.configs.overrides").mason.ensure_installed
	local missing = {}
	for _, package in ipairs(ensure_installed) do
		if not vim.tbl_contains(mason_installed, package) then
			table.insert(missing, package)
		end
	end
	local remove = {}
	for _, package in ipairs(mason_installed) do
		if
			not vim.tbl_contains(ensure_installed, package)
			and package ~= "stylua"
			and package ~= "lua-language-server"
		then
			table.insert(remove, package)
		end
	end
	if #remove > 0 then
		vim.cmd("MasonUninstall " .. table.concat(remove, " "))
	end
	if #missing > 0 then
		vim.cmd("MasonInstall " .. table.concat(missing, " "))
	end
end

M.CreateCustom = function()
	local path = vim.fn.stdpath("config") .. "/lua/custom"
	if vim.fn.isdirectory(path) ~= 1 then
		vim.fn.mkdir(path, "p")
		local file = io.open(path .. "/init.lua", "w")
		file:write(
			'local M = {}\n\nM.keymaps = require("custom.keymaps")\nM.options = require("custom.options")\n\nM.plugins = "custom.plugins"\n\nreturn M'
		)
		local plugins = io.open(path .. "/plugins.lua", "w")
		plugins:write(
			'local overrides = require("custom.configs.overrides")\n\nlocal plugins = {\n\n-- add plugins or override my plugins in here\n\n}\n\nreturn plugins'
		)
		vim.fn.mkdir(path .. "/configs", "p")
		local overrides = io.open(path .. "/configs/overrides.lua", "w")
		overrides:write("local M = {}\n\n-- add overrides in here\n\nreturn M")
		local options = io.open(path .. "/options.lua", "w")
		options:write("-- add options or override my options in here")
		local keymaps = io.open(path .. "/keymaps.lua", "w")
		keymaps:write("-- add your keymaps in here")
		vim.fn.mkdir(path .. "/themes/schemes", "p")
		local themes = io.open(path .. "/themes/schemes/yourtheme.lua", "w")
		themes:write(
			"local M = {}\n\nfunction M.get_colors()\n\treturn {\n\t\t-- add your colors in here(check my color to setup)\n\t}\nend\n\nreturn M"
		)
		vim.notify("Created custom folder. Please read the docs!")
	end
end

return M
