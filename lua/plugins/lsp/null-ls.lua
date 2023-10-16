local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

local formatting = null_ls.builtins.formatting   -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- To setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = true,
	sources = {
		-- Webdev stuff
		formatting.deno_fmt.with({ extra_args = { "--style", "{IndentWidth: 4}" } }),
		formatting.prettier.with({ extra_args = { "--style", "{IndentWidth: 4}" } }),

		-- Lua
		formatting.stylua.with({ extra_args = { "--style", "{IndentWidth: 4}" } }),

		-- Cpp, C with indent width 4
		formatting.clang_format.with({ extra_args = { "--style", "{IndentWidth: 4}" } }),

		-- Python
		formatting.black.with({ extra_args = { "--style", "{IndentWidth: 4}" } }),

		-- JS/TS Linter
		diagnostics.eslint_d.with({
			condition = function(utils)
				return utils.root_has_file(".eslintrc.js")
			end,
		}),
		-- Gitsigns
		null_ls.builtins.code_actions.gitsigns,
	},

	-- configure format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, timeout = 100 })
				end,
			})
		end
	end,
})
