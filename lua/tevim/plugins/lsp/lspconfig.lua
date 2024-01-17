local M = {}
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status_ok then
	return
end

M.on_attach = function(client, bufnr)
	if client.supports_method("textDocument/inlayHint") then
		local value
		local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
		if type(ih) == "function" then
			ih(bufnr, value)
		elseif type(ih) == "table" and ih.enable then
			if value == nil then
				value = not ih.is_enabled(bufnr)
			end
			ih.enable(bufnr, value)
		end
	end
	require("lsp_signature").on_attach({
		bind = true,
		handler_opts = { border = "rounded" },
	}, bufnr)
end

M.capabilities =
	vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities())

M.capabilities.offsetEncoding = { "utf-16", "utf-8" }

vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	signs = { text = { [1] = "", [2] = "", [3] = "", [4] = "", [5] = "" } },
	float = {
		focusable = false,
		suffix = "",
		header = { "  Diagnostics", "String" },
		prefix = function(_, _, _)
			return "  ", "String"
		end,
	},
})

-- CONFIGS
lspconfig.lua_ls.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	settings = {
		Lua = {
			hint = { enable = true },
			diagnostics = { globals = { "vim", "awesome", "client", "screen", "mouse", "tag" } },
			workspace = { checkThirdParty = false },
		},
	},
})

return M
