local configs = {
	formatOnSave = true,
	formatters_by_ft = {
		lua = { "stylua" },
	},
	format = {
		timeout_ms = 3000,
		async = false,
		quiet = false,
	},
}

return configs
