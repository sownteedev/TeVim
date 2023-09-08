local M = {}
local hl_files = vim.fn.stdpath "config" .. "/lua/themes/integrations"

local highlights = {}

function M.highlight_all(colors, opts)
	if opts.transparent_background == true then
		colors.background = "none"
	end
	for _, file in ipairs(vim.fn.readdir(hl_files)) do
		local integration = require("themes.integrations." .. vim.fn.fnamemodify(file, ":r"))
		highlights = vim.tbl_deep_extend("force", highlights, integration(colors))
	end
	for group, properties in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, properties)
	end
end

return M
