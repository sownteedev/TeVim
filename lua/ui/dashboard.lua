local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

math.randomseed(os.time())
local function footer()
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date("  %d-%m-%Y        %H:%M:%S")
    local version = vim.version()
    local nvim_version_info = "         v" .. version.major .. "." .. version.minor .. "." .. version.patch

    return datetime .. "       " .. total_plugins .. " plugins" .. nvim_version_info
end

local header = {
    [[  ███████╗  ██████╗  ██╗   ██╗   ██╗ ███╗   ██╗ ████████╗ ███████╗ ███████╗  ⠀⠀⠀  ███████╗  ███████╗ ██╗   ██╗]],
    [[  ██╔════╝ ██╔═══██╗ ██║   ██║   ██║ ████═╗ ██║ ╚══██╔══╝ ██╔════╝ ██╔════╝       ██╔═══██╗ ██╔════╝ ██║   ██║]],
    [[  ███████╗ ██║   ██║ ██║   ██║   ██║ ██╔███╗██║    ██║    █████╗   █████╗   ████╗ ██║   ██║ █████╗   ██║   ██║]],
    [[  ╚════██║ ██║   ██║ ╚██╗ ████╗ ██╔╝ ██║╚═████║    ██║    ██╔══╝   ██╔══╝    ╚══╝ ██║   ██║ ██╔══╝   ╚██╗ ██╔╝]],
    [[███████║ ╚██████╔╝  ╚████╔╚████╔╝  ██║  ╚███║    ██║    ███████╗ ███████╗      ⠀███████╔╝ ███████╗  ╚████╔╝]],
    [[╚══════╝  ╚═════┘    ╚═══╝ ╚═══╝   ╚═╝  ⠀ ╚═╝    ╚═╝    ╚══════╝ ╚══════╝        ╚═════╝  ╚══════╝   ╚═══╝]],
    [[ ]],
    [[ ━━━━━━━━━━━━━━━━━━  ❖  ━━━━━━━━━━━━━━━━━━]]
}

-- local function colorize_header()
--     local colors = {
--         "#f38ba8",
--         "#fab387",
--         "#f9e2af",
--         "#a6e3a1",
--         "#89dceb",
--         "#89b4fa",
--         "#cba6f7",
--         "#f5c2e7",
--     }
--     for i, color in pairs(colors) do
--         local cmd = "hi StartLogo" .. i .. " guifg=" .. color
--         vim.cmd(cmd)
--     end
--     local lines = {}
--     for i, chars in pairs(header) do
--         local line = {
--             type = "text",
--             val = chars,
--             opts = {
--                 hl = "StartLogo" .. i,
--                 shrink_margin = false,
--                 position = "center",
--             },
--         }
--         table.insert(lines, line)
--     end
--     return lines
-- end

dashboard.section.buttons.val = {
    dashboard.button("1", " " .. "   New File", ":ene <BAR> startinsert <CR>"),
    dashboard.button("2", " " .. "   Bookmarks", ":Reach marks<CR>"),
    dashboard.button("3", " " .. "   Find File", ":Telescope find_files theme=dropdown initial_mode=insert<cr>"),
    -- dashboard.button("4", " " .. "   Recent files", ":Telescope oldfiles<CR>"),
    -- dashboard.button("5", " " .. "   Search Word", ":Telescope live_grep theme=dropdown<CR>"),
    dashboard.button("4", " " .. "   Select Themes",
        ":lua require('themes.switch').setup(require('telescope.themes').get_dropdown{})<CR>"),
    -- dashboard.button("7", " " .. "   Ranger", ":RnvimrToggle<CR>"),
    -- dashboard.button("8", " " .. "   Lazygit", ":lua LazyGit()<CR>"),
    -- dashboard.button("9", " " .. "   Mason", ":Mason<CR>"),
    dashboard.button("5", " " .. "   Quit", ":qa<CR>"),
    -- dashboard.button(
    --     "t",
    --     " " .. "   TODO",
    --     ":TodoTelescope keywords=TODO,FIX,BUG,FIXIT,ISSUE,FIXME,ERROR,WARNING,INFO,HINT,TEST,HACK,PERF,NOTE<CR>"
    -- ),
}
for _, button in ipairs(dashboard.section.buttons.val) do
    button.opts.hl = "AlphaButtons"
    button.opts.hl_shortcut = "AlphaShortcut"
end
dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"
vim.b.miniindentscope_disable = true

alpha.setup({
    layout = {
        { type = "padding", val = 5 },
        -- { type = "group",   val = colorize_header() },
        { type = "padding", val = 3 },
        dashboard.section.buttons,
        { type = "padding", val = 3 },
        dashboard.section.footer,
    },
    opts = { margin = 10 },
})
