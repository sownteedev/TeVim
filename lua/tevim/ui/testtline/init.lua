local M = {}

M.run = function()
	local mode = require("tevim.ui.testtline.modules.mode")
	local filename = require("tevim.ui.testtline.modules.filename")
	local branch = require("tevim.ui.testtline.modules.branch")
	local diff = require("tevim.ui.testtline.modules.diff")
	local diagnostics = require("tevim.ui.testtline.modules.diagnostics")
	local lsp = require("tevim.ui.testtline.modules.lsp")
	local copilot = require("tevim.ui.testtline.modules.copilot")
	local tab = require("tevim.ui.testtline.modules.tab")
	local progress = require("tevim.ui.testtline.modules.progress")
	local location = require("tevim.ui.testtline.modules.location")
	local tree = require("tevim.ui.testtline.modules.tree")
	local nothing = require("tevim.ui.testtline.modules.nothing")
	if vim.bo.filetype == "tedash" then
		return table.concat({
			nothing(),
		})
	elseif vim.o.columns < 120 and vim.bo.filetype ~= "tedash" then
		return table.concat({
			tree(),
			"%#TeSTTNothing2#" .. " ",
			"%=",
			mode(),
			nothing(),
			diagnostics(),
		})
	end
	return table.concat({
		mode(),
		nothing(),
		filename(),
		nothing(),
		branch(),
		nothing(),
		diff(),
		nothing(),
		"%=",
		diagnostics(),
		lsp(),
		copilot(),
		nothing(),
		tab(),
		nothing(),
		progress(),
		nothing(),
		location(),
	})
end

M.setup = function()
	vim.opt.laststatus = 3
	vim.opt.statusline = M.run()
	vim.api.nvim_create_autocmd({ "ModeChanged", "CursorHold", "VimResized" }, {
		callback = function()
			vim.opt.statusline = M.run()
		end,
	})
end

return M
