local M = {}

function M.is_available(plugin)
	local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
	return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

function M.toggle_option(option)
	local value = not vim.api.nvim_get_option_value(option, {})
	vim.opt[option] = value
	local options = io.open(vim.fn.stdpath("config") .. "/lua/custom/options.lua", "a")
	if options == nil then
		vim.notify("Please create a custom folder to save options! Use :TeVimCreateCustom")
	else
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
	end
	vim.notify(option .. " set to " .. tostring(value))
end

function M.toggle_tabline()
	local value = vim.api.nvim_get_option_value("showtabline", {})
	if value == 2 then
		value = 0
	else
		value = 2
	end
	vim.opt.showtabline = value
	vim.notify("showtabline" .. " set to " .. tostring(value))
end

function M.toggle_statusline()
	local value = vim.api.nvim_get_option_value("laststatus", {})
	if value == 3 then
		value = 0
	else
		value = 3
	end
	vim.opt.laststatus = value
	vim.notify("laststatus" .. " set to " .. tostring(value))
end

function M.toggle_inlayHint()
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

function M.toggle_formatOnSave()
	local formatOnSave = require("tevim.plugins.lsp.conform").formatOnSave
	if formatOnSave then
		require("tevim.plugins.lsp.conform").formatOnSave = false
		vim.notify("Format on save disabled")
	else
		require("tevim.plugins.lsp.conform").formatOnSave = true
		vim.notify("Format on save enabled")
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
	for _, cmd in ipairs({ "lazygit" }) do
		local name = type(cmd) == "string" and cmd or vim.inspect(cmd)
		local commands = type(cmd) == "string" and { cmd } or cmd
		---@cast commands string[]
		for _, c in ipairs(commands) do
			if vim.fn.executable(c) == 0 then
				return vim.notify(("%s isn't installed"):format(name))
			end
		end
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
	for _, cmd in ipairs({ "ranger" }) do
		local name = type(cmd) == "string" and cmd or vim.inspect(cmd)
		local commands = type(cmd) == "string" and { cmd } or cmd
		---@cast commands string[]
		for _, c in ipairs(commands) do
			if vim.fn.executable(c) == 0 then
				return warn(("%s isn't installed"):format(name))
			end
		end
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

M.CreateCustom = function()
	local path = vim.fn.stdpath("config") .. "/lua/custom"
	if vim.fn.isdirectory(path) ~= 1 then
		vim.fn.mkdir(path, "p")
		local file = io.open(path .. "/init.lua", "w")
		file:write(
			'local M = {}\n\nM.keymaps = require("custom.keymaps")\nM.options = require("custom.options")\n\nM.plugins = "custom.plugins"\n\nreturn M'
		)
		local plugins = io.open(path .. "/plugins.lua", "w")
		plugins:write("local plugins = {\n\n-- add plugins or override my plugins in here\n\n}\n\nreturn plugins")
		local options = io.open(path .. "/options.lua", "w")
		options:write("-- add options or override my options in here")
		local keymaps = io.open(path .. "/keymaps.lua", "w")
		keymaps:write("-- add your keymaps in here")
		vim.notify("Created custom folder. Please read the docs!")
	end
end

return M
