local status_ok, which_key = pcall(require, "which-key")

if not status_ok then
    return
end

local setup = {
    operators = { gc = "Comments" },
    key_labels = {
        ["<space>"] = "SPACE",
        ["<leader>"] = "SPACE",
        ["<cr>"] = "RETURN",
        ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "",
        separator = "",
        group = " ",
    },
    window = {
        border = "none",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 0, 0, 0, 0 },
        winblend = 0,
    },
    layout = {
        height = { min = 2, max = 20 },
        width = { min = 20, max = 50 },
        spacing = 5,
        align = "center",
    },
    ignore_missing = true,
    -- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
    show_help = true,
    triggers = { "<leader>" },
    triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local mappings = {
    ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment" },
    ["q"] = { ":qa!<CR>", "Quit" },
    p = {
        name = "󰏖  PACKER",
        C = { "<cmd>PackerClean<cr>", "Clean" },
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    o = {
        name = "  OPTIONS",
        w = { '<cmd>lua require("user.functions").toggle_option("wrap")<cr>', "Wrap" },
        s = { '<cmd>lua require("user.functions").toggle_option("spell")<cr>', "Spell" },
        t = { '<cmd>lua require("user.functions").toggle_tabline()<cr>', "Tabline" },
        g = { '<cmd>lua require("user.functions").build_run()<cr>', "Build & Run" },
    },
    w = {
        name = "  WINDOWS",
        v = { "<C-w>v", "Vertical Split" },
        h = { "<C-w>s", "Horizontal Split" },
        e = { "<C-w>=", "Make Splits Equal" },
        q = { ":close<CR>", "Close Split" },
    },
    d = {
        name = "  DEBUG",
        b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
        O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
        r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
        l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
        u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
        x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
    },
    f = {
        name = "  TELESCOPE",
        C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        c = { "<cmd>lua require('themes.switch').setup(require('telescope.themes').get_dropdown{})<cr>", "Select Themes" },
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        a = { "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", "FindAll" },
        r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
        w = { "<cmd>Telescope live_grep<cr>", "Find Text" },
        m = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        s = { "<cmd>Telescope grep_string <cr>", "Find String" },
        l = { "<cmd>Telescope resume<cr>", "Last Search" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        j = { "<cmd>Telescope commands<cr>", "Commands" },
        h = { "<cmd>Telescope highlights<cr>", "Help" },
        p = { "<cmd>Telescope projects<cr>", "Projects" },
    },
    g = {
        name = "󰊢  GIT",
        g = { "<cmd>lua LazyGit()<CR>", "Lazygit" },
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
    },
    l = {
        name = "  LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
        w = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
        f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
        F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        j = { "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", "Next Diagnostic" },
        k = { "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", "Prev Diagnostic" },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        o = { "<cmd>Lspsaga outline<cr>", "Outline" },
        q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
        u = { "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet" },
    },
    t = {
        name = "  TERMINAL",
        ["1"] = { ":1ToggleTerm<cr>", "1" },
        ["2"] = { ":2ToggleTerm<cr>", "2" },
        ["3"] = { ":3ToggleTerm<cr>", "3" },
        ["4"] = { ":4ToggleTerm<cr>", "4" },
        f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
        h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
        v = { "<cmd>ToggleTerm size=50 direction=vertical<cr>", "Vertical" },
    },
}

local vmappings = {
    ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
