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
			'local overrides = require("custom.configs.overrides")\n\nlocal plugins = {\n\n\t-- add plugins or override my plugins in here\n\n}\n\nreturn plugins'
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
		themes:write("return {\n\t-- add your colors in here(check my color to setup)\n}")
		local integrations = io.open(path .. "/themes/integrations.lua", "w")
		integrations:write(
			'local colors = require("tevim.themes").getCurrentTheme()\n\nreturn {\n\t-- add your highlights in here\n}'
		)
		vim.notify("Created custom folder. Please read the docs!")
	end
end

------------------------------------ FOR THEMES ------------------------------------------
local function hexToRgb(c)
	c = string.lower(c)
	return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

local function rgbToHsl(r, g, b)
	r, g, b = r / 255, g / 255, b / 255
	local max = math.max(r, g, b)
	local min = math.min(r, g, b)
	local h, s, l
	l = (max + min) / 2
	if max == min then
		h = 0
		s = 0
	else
		local d = max - min
		s = l > 0.5 and d / (2 - max - min) or d / (max + min)
		if max == r then
			h = (g - b) / d + (g < b and 6 or 0)
		elseif max == g then
			h = (b - r) / d + 2
		else
			h = (r - g) / d + 4
		end
		h = h / 6
	end
	return h, s, l
end

local function hslToRgb(h, s, l)
	if s == 0 then
		return l, l, l
	end
	h = (h % 1 + 1) % 1
	s = math.min(1, math.max(0, s))
	l = math.min(1, math.max(0, l))
	local function hueToRgb(p, q, t)
		if t < 0 then
			t = t + 1
		end
		if t > 1 then
			t = t - 1
		end
		if t < 1 / 6 then
			return p + (q - p) * 6 * t
		end
		if t < 1 / 2 then
			return q
		end
		if t < 2 / 3 then
			return p + (q - p) * (2 / 3 - t) * 6
		end
		return p
	end
	local q = l < 0.5 and l * (1 + s) or l + s - l * s
	local p = 2 * l - q
	local r = hueToRgb(p, q, h + 1 / 3)
	local g = hueToRgb(p, q, h)
	local b = hueToRgb(p, q, h - 1 / 3)

	return r, g, b
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

M.saturate = function(c, factor)
	local r = tonumber(string.sub(c, 2, 3), 16)
	local g = tonumber(string.sub(c, 4, 5), 16)
	local b = tonumber(string.sub(c, 6, 7), 16)
	local h, s, l = rgbToHsl(r, g, b)
	s = s + factor

	s = math.min(1, math.max(0, s))

	r, g, b = hslToRgb(h, s, l)
	local newHexColor = string.format("#%02X%02X%02X", r * 255, g * 255, b * 255)

	return newHexColor
end

M.moreRed = function(c, f)
	local r = tonumber(string.sub(c, 2, 3), 16)
	local g = tonumber(string.sub(c, 4, 5), 16)
	local b = tonumber(string.sub(c, 6, 7), 16)
	r = r + f
	r = math.min(255, math.max(0, r))
	return string.format("#%02X%02X%02X", r, g, b)
end

M.moreGreen = function(c, f)
	local r = tonumber(string.sub(c, 2, 3), 16)
	local g = tonumber(string.sub(c, 4, 5), 16)
	local b = tonumber(string.sub(c, 6, 7), 16)
	g = g + f
	g = math.min(255, math.max(0, g))
	return string.format("#%02X%02X%02X", r, g, b)
end

M.moreBlue = function(c, f)
	local r = tonumber(string.sub(c, 2, 3), 16)
	local g = tonumber(string.sub(c, 4, 5), 16)
	local b = tonumber(string.sub(c, 6, 7), 16)
	b = b + f
	b = math.min(255, math.max(0, b))
	return string.format("#%02X%02X%02X", r, g, b)
end

M.warm = function(c, f)
	local r = tonumber(string.sub(c, 2, 3), 16)
	local g = tonumber(string.sub(c, 4, 5), 16)
	local b = tonumber(string.sub(c, 6, 7), 16)
	r = r + f
	g = g + f
	r = math.min(255, math.max(0, r))
	g = math.min(255, math.max(0, g))
	return string.format("#%02X%02X%02X", r, g, b)
end

return M
