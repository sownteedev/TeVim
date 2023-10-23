local M = function()
	if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
		return ""
	end

	local git_status = vim.b.gitsigns_status_dict

	local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
	local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
	local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
	if (#added > 0) or (#changed > 0) or (#removed > 0) then
		return "%#TeSTTDiffAdd#" ..
			added ..
			"%#TeSTTDiffChange#" .. changed .. "%#TeSTTDiffRemove#" .. removed .. " " .. "%#TeSTTGithub#" .. "  "
	else
		return ""
	end
end

return M
