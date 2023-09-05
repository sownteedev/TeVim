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

vim.diagnostic.config(config)
mason.setup(config)

require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",

        "html",
        "cssls",
        "tsserver",
        "tailwindcss",
        "volar",
        "eslint",
        "denols",
        "emmet_ls",
        "jsonls",

        "pyright",

        "clangd",
    },
}

require("mason-null-ls").setup({
    ensure_installed = {
        "stylua",
        "clang-format",
        "prettier",
        "black",
        "eslint_d",
    },
    automatic_installation = true,
    automatic_setup = false,
})
