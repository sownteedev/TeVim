local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status_ok then
	return
end

local navic_lsp_status_ok, navic = pcall(require, "nvim-navic")
if not navic_lsp_status_ok then
	return
end

local protocol = require("vim.lsp.protocol")

local on_attach = function(client, bufnr)
	-- Navic
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(),
	require("cmp_nvim_lsp").default_capabilities())

capabilities.offsetEncoding = { "utf-16" }

vim.diagnostic.config({
	virtual_text = { prefix = " ●" },
	signs = true,
	underline = false,
	update_in_insert = false,
	severity_sort = true,
})

protocol.CompletionItemKind = {
	" ", -- Text
	" ", -- Method
	" ", -- Function
	" ", -- Constructor
	" ", -- Field
	" ", -- Variable
	" ", -- Class
	" ", -- Interface
	" ", -- Module
	" ", -- Property
	" ", -- Unit
	" ", -- Value
	" ", -- Enum
	" ", -- Keyword
	"﬌ ", -- Snippet
	" ", -- Color
	" ", -- File
	" ", -- Reference
	" ", -- Folder
	" ", -- EnumMember
	" ", -- Constant
	" ", -- Struct
	" ", -- Event
	"ﬦ ", -- Operator
	" ", -- TypeParameter
}

-- Change the Diagnostic symbols
local signs = { Error = " ", Warn = " ", Hint = "󰌵", Info = " ", Question = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- CONFIGS
lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = vim.tbl_deep_extend("keep", { offsetEncoding = { "utf-16", "utf-8" } }, capabilities),
})

lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			completion = {
				callSnippet = "Replace"
			},
			workspace = {
				checkThirdParty = false,
				library = {
					[vim.fn.expand "$VIMRUNTIME/lua"] = true,
					[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
				},
				maxPreload = 50000,
				preloadFileSize = 10000,
			},
		},
	},
})

lspconfig.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.vuels.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.eslint.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
