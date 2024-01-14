local treeWidth = function()
	for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.bo[vim.api.nvim_win_get_buf(win)].ft == "neo-tree" then
			return vim.api.nvim_win_get_width(win)
		end
	end
	return 0
end

local M = function()
	local treespace
	if treeWidth() > 2 then
		treespace = "%#TeBufTree#"
			.. string.rep(" ", treeWidth() / 2 - 3)
			.. "      "
			.. string.rep(" ", treeWidth() / 2 - 2)
	else
		treespace = "%#TeBufTree#" .. string.rep(" ", treeWidth())
	end
	return treespace
end
return M
