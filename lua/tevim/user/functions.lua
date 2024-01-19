local M = {}

function M.toggle_option(option)
	local value = not vim.api.nvim_get_option_value(option, {})
	vim.opt[option] = value
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

local lazygit = require("toggleterm.terminal").Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	direction = "float",
	float_opts = { border = "curved" },
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
})
function M.LazyGit()
	lazygit:toggle()
end

local ranger = require("toggleterm.terminal").Terminal:new({
	cmd = "ranger",
	dir = "git_dir",
	direction = "float",
	float_opts = { border = "curved" },
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
})
function M.Ranger()
	ranger:toggle()
end

M.CreateCustom = function()
	local path = vim.fn.stdpath("config") .. "/lua/custom"
	if vim.fn.isdirectory(path) ~= 1 then
		vim.fn.mkdir(path, "p")
		local file = io.open(path .. "/init.lua", "w")
		file:write('local M = {}\n\nM.plugins = "custom.plugins"\n\nreturn M')
		local plugins = io.open(path .. "/plugins.lua", "w")
		plugins:write("local plugins = {}\n\nreturn plugins")
	end
end

return M
