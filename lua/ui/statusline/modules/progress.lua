local M = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "  ", " 󰪞 ", " 󰪟 ", " 󰪠 ", " 󰪢 ", " 󰪣 ", " 󰪤 ", " 󰪥 " }
	local progress_percent = current_line / total_lines
	local index = math.ceil(progress_percent * #chars)
	if current_line == 1 then
		return "%#TeSTTProgressIcon#" ..
			chars[index] .. "%#TeSTTProgress#" .. ' Top '
	elseif current_line == total_lines then
		return "%#TeSTTProgressIcon#" ..
			chars[index] .. "%#TeSTTProgress#" .. ' Bot '
	else
		return "%#TeSTTProgressIcon#" ..
			chars[index] ..
			"%#TeSTTProgress#" .. string.format(' %2d%%%% ', math.floor(current_line / total_lines * 100))
	end
end

return M
