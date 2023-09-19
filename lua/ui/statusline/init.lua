local run = function()
	local mode = require("ui.statusline.modules.mode")
	local filename = require("ui.statusline.modules.filename")
	local branch = require("ui.statusline.modules.branch")
	local diff = require("ui.statusline.modules.diff")
	local diagnostics = require("ui.statusline.modules.diagnostics")
	local lsp = require("ui.statusline.modules.lsp")
	local copilot = require("ui.statusline.modules.copilot")
	local folder = require("ui.statusline.modules.folder")
	local tab = require("ui.statusline.modules.tab")
	local location = require("ui.statusline.modules.location")
	local nothing = require("ui.statusline.modules.nothing")
	return table.concat {
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
		folder(),
		nothing(),
		tab(),
		nothing(),
		location(),
	}
end

local setup = function()
	vim.opt.statusline = run()
	vim.api.nvim_create_autocmd({ "ModeChanged", "CursorHold" }, {
		callback = function()
			vim.opt.statusline = run()
		end
	})
end

return { run = run, setup = setup }
