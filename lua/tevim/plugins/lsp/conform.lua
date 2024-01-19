local configs = {
	formatters_by_ft = {
		lua = { "stylua" },
	},
	format = {
		timeout_ms = 3000,
		async = false,
		quiet = false,
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

return configs
