local M = {}

local cmp_nvim_lsp = require("cmp_nvim_lsp")

M.inlay_hints = true

M.on_attach = function(client, bufnr)
	if M.inlay_hints and client:supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
	require("lsp_signature").on_attach({
		bind = true,
		handler_opts = { border = "rounded" },
	}, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	signs = { text = { [1] = "", [2] = "", [3] = "", [4] = "󰌶" } },
	float = {
		suffix = "",
		header = { "  Diagnostics", "String" },
		prefix = function(_, _, _)
			return "  ", "String"
		end,
	},
})

vim.lsp.config("lua_ls", {
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = { checkThirdParty = false },
		},
	},
})
vim.lsp.enable("lua_ls")

return M
