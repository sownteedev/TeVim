local M = {}

function M.is_available(plugin)
	local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
	return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

function M.replaceword(middle, old, new, file)
	local lines = vim.fn.readfile(file)
	local new_lines = {}
	local found = false
	for _, line in ipairs(lines) do
		if line:find(middle) then
			if line:find(old) then
				table.insert(new_lines, middle .. " = " .. new)
			else
				table.insert(new_lines, middle .. " = " .. old)
			end
			found = true
		else
			table.insert(new_lines, line)
		end
	end
	if not found then
		table.insert(new_lines, middle .. " = " .. new)
	end
	vim.fn.writefile(new_lines, file)
end

function M.toggle_option(option)
	local value = not vim.api.nvim_get_option_value(option, {})
	vim.opt[option] = value
	M.replaceword(
		"vim.opt." .. option,
		tostring(not value),
		tostring(value),
		vim.fn.stdpath("config") .. "/lua/custom/options.lua"
	)
	vim.notify(option .. " set to " .. tostring(value))
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
	elseif not M.is_available("markdown-preview.nvim") and filetype == "markdown" then
		vim.notify("You can install plugins support for markdown like markdown-preview.nvim ^^")
	elseif filetype == "html" and vim.fn.executable("live-server") ~= 1 then
		vim.notify("You can install live-server by npm ^^")
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
	local default_mason = { "lua-language-server", "stylua" }
	for _, package in ipairs(default_mason) do
		table.insert(ensure_installed, package)
	end
	local missing = {}
	for _, package in ipairs(ensure_installed) do
		if not vim.tbl_contains(mason_installed, package) then
			table.insert(missing, package)
		end
	end
	local remove = {}
	for _, package in ipairs(mason_installed) do
		if not vim.tbl_contains(ensure_installed, package) then
			table.insert(remove, package)
		end
	end
	if #remove > 0 then
		vim.cmd("MasonUninstall " .. table.concat(remove, " "))
	end
	if #missing > 0 then
		vim.cmd("MasonInstall " .. table.concat(missing, " "))
	end
	if #missing == 0 and #remove == 0 then
		vim.notify("Nothing to install or uninstall")
	end
end

M.CreateCustom = function()
	local path = vim.fn.stdpath("config") .. "/lua/custom"
	if vim.fn.isdirectory(path) ~= 1 then
		vim.fn.mkdir(path, "p")
		io.open(path .. "/init.lua", "w"):write(
			'local M = {}\n\nM.keymaps = require("custom.keymaps")\nM.options = require("custom.options")\n\nreturn M'
		)
		io.open(path .. "/plugins.lua", "w"):write(
			'local overrides = require("custom.configs.overrides")\n\nreturn {\n\t-- add plugins or override my plugins in here\n}'
		)
		vim.fn.mkdir(path .. "/configs", "p")
		io.open(path .. "/configs/overrides.lua", "w"):write(
			"local M = {}\n\n-- add overrides in here(eg: mason.nvim)\nM.mason = {\n\tensure_installed = {}\n}\n\nreturn M"
		)
		io.open(path .. "/options.lua", "w"):write("-- add options or override my options in here")
		io.open(path .. "/keymaps.lua", "w"):write("-- add your keymaps in here")
		vim.fn.mkdir(path .. "/themes/schemes", "p")
		io.open(path .. "/themes/integrations.lua", "w"):write(
			'local colors = require("tevim.themes").getCurrentTheme()\n\nreturn {\n\t-- add your highlights in here\n}'
		)
		vim.notify("Created custom folder. Please read the docs!")
	end
end

M.TeVimUpdate = function()
	local output = vim.fn.system("git -C " .. vim.fn.stdpath("config") .. " pull")
	if output == "Already up to date.\n" then
		vim.notify("Nothing to update!")
	else
		vim.notify("TeVim updated! Please restart Neovim! If you have any problem, please report to me!")
	end
end

------------------------------------ FOR THEMES ------------------------------------------
local function hexToRgb(c)
	c = string.lower(c)
	return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

M.blend = function(foreground, background, alpha)
	alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
	local bg = hexToRgb(background)
	local fg = hexToRgb(foreground)
	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

M.mix = function(c1, c2, wt)
	local r1 = tonumber(string.sub(c1, 2, 3), 16)
	local g1 = tonumber(string.sub(c1, 4, 5), 16)
	local b1 = tonumber(string.sub(c1, 6, 7), 16)

	local r2 = tonumber(string.sub(c2, 2, 3), 16)
	local g2 = tonumber(string.sub(c2, 4, 5), 16)
	local b2 = tonumber(string.sub(c2, 6, 7), 16)

	wt = math.min(1, math.max(0, wt))

	local nr = math.floor((1 - wt) * r1 + wt * r2)
	local ng = math.floor((1 - wt) * g1 + wt * g2)
	local nb = math.floor((1 - wt) * b1 + wt * b2)

	return string.format("#%02X%02X%02X", nr, ng, nb)
end

return M
