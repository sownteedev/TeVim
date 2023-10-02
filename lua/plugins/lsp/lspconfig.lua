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

local on_attach = function(client, bufnr)
	-- Navic
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint(bufnr, true)
	end
end

local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(),
	cmp_nvim_lsp.default_capabilities())

capabilities.offsetEncoding = { "utf-16" }

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		focusable = false,
		suffix = '',
		header = { "  Diagnostics", "String" },
		prefix = function(_, _, _) return "  ", "String" end,
	}
})

-- Change the Diagnostic symbols
local signs = { Error = " ", Warn = " ", Hint = "", Info = " ", Question = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- CONFIGS
local servers = {
	"cssls",
	"html",
	"tsserver",
	"tailwindcss",
	"vuels",
	"eslint",
	"pyright",
	"emmet_ls",
	"jsonls",
	"vimls",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = vim.tbl_deep_extend("keep", { offsetEncoding = { "utf-16", "utf-8" } }, capabilities),
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand "$VIMRUNTIME/lua"] = true,
					[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
					[vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})
