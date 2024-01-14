local M = {}

M.tebufilter = function()
	local bufs = vim.api.nvim_list_bufs() or nil

	if not bufs then
		return {}
	end

	for i = #bufs, 1, -1 do
		local filename = (#vim.api.nvim_buf_get_name(bufs[i]) ~= 0)
				and vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufs[i]), ":t")
			or ""
		if
			not vim.api.nvim_buf_is_valid(bufs[i])
			or not vim.bo[bufs[i]].buflisted
			or not vim.api.nvim_buf_is_loaded(bufs[i])
			or filename == ""
		then
			table.remove(bufs, i)
		end
	end

	return bufs
end

M.tebuflinePrev = function()
	local bufs = M.tebufilter()
	for i, v in ipairs(bufs) do
		if vim.api.nvim_get_current_buf() == v then
			vim.cmd(i == 1 and "b" .. bufs[#bufs] or "b" .. bufs[i - 1])
			break
		end
	end
end
M.tebuflineNext = function()
	local bufs = M.tebufilter()

	for i, v in ipairs(bufs) do
		if vim.api.nvim_get_current_buf() == v then
			vim.cmd(i == #bufs and "b" .. bufs[1] or "b" .. bufs[i + 1])
			break
		end
	end
end

M.close_buffer = function(bufnr)
	if vim.bo.buftype == "terminal" then
		vim.cmd(vim.bo.buflisted and "set nobl | enew" or "hide")
	else
		bufnr = bufnr or vim.api.nvim_get_current_buf()
		if bufnr == vim.api.nvim_get_current_buf() then
			M.tebuflinePrev()
		end
		vim.cmd("confirm bd" .. bufnr)
	end
end

M.close_other_buffers = function()
	local bufs = M.tebufilter()
	local current_buf = vim.api.nvim_get_current_buf()
	for _, v in ipairs(bufs) do
		if v ~= current_buf then
			vim.cmd("confirm bd" .. v)
		end
	end
end

return M
