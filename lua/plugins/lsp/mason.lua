local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	return
end

local config = {
	ui = {
		icons = {
			package_pending = "󰁇 ",
			package_installed = " ",
			package_uninstalled = " ",
		},
		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			update_all_servers = "U",
			check_server_version = "c",
			check_outdated_servers = "C",
			uninstall_server = "X",
			cancel_installation = "<C-c>",
		},
	},
}

mason.setup(config)
local install_server = {
	"lua-language-server",
	"stylua",

	"css-lsp",
	"html-lsp",
	"typescript-language-server",
	"prettier",
	"tailwindcss-language-server",
	"vue-language-server",
	"eslint-lsp",
	"deno",
	"emmet-ls",
	"json-lsp",
	"eslint_d",

	"pyright",
	"black",

	"clangd",
	"clang-format",
	"vim-language-server",
	"jdtls",
}
vim.api.nvim_create_user_command("MasonInstallAll", function()
	vim.cmd("MasonInstall " .. table.concat(install_server, " "))
end, {})
