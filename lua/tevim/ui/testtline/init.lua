local run = function()
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

	if vim.o.columns < 120 then
		return table.concat {
			tree(),
			"%#Nothing2#" .. " ",
			"%=",
			mode(),
			nothing(),
			diagnostics(),
		}
	else
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
			tab(),
			nothing(),
			progress(),
			nothing(),
			location(),
		}
	end
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
