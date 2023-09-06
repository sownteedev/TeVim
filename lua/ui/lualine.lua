local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

-- Require theme color you're using
local colors = require('themes.schemes.yoru').get_colors()

-- local hide_in_width = function()
--     return vim.fn.winwidth(0) > 80
-- end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = {
        error = " ",
        warn = " ",
        hint = " ",
        info = " ",
    },
    colored = true,
    diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.orange },
        color_info = { fg = colors.blue },
        color_hint = { fg = colors.purple }
    },
    always_visible = false,
    update_in_insert = true,
}

local branch = {
    "branch",
    icon = "",
    color = { fg = colors.dark_purple },
    padding = { left = 2, right = 2 },
}

local diff = {
    "diff",
    colored = true,
    color = {
        added    = 'DiffAdd',
        modified = 'DiffChange',
        removed  = 'DiffDelete',
    },
    symbols = { added = " ", modified = " ", removed = " " },
    padding = { left = -1, right = 1 },
}

local location = {
    "location",
    padding = 1,
}

local modes = {
    function()
        -- local animated = {
        -- "  ",
        -- "  ",
        -- " 󱠡 ",
        -- }
        -- return animated[os.date("%S") % #animated + 1]
        local animated = "  "
        return animated
    end,
    separator = { left = "", right = "" },
}

local indent = function()
    return "" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local lsp_progess = function()
    local msg
    msg = msg or "✖"
    local buf_clients = vim.lsp.get_active_clients()
    if next(buf_clients) == nil then
        if type(msg) == "boolean" or #msg == 0 then
            return "NO LSP"
        end
        return msg
    end
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}
    local copilot_active = true
    local null_ls = require("null-ls")
    local alternative_methods = {
        null_ls.methods.DIAGNOSTICS,
        null_ls.methods.DIAGNOSTICS_ON_OPEN,
        null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }

    -- add client
    for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" and client.name ~= "copilot" then
            table.insert(buf_client_names, client.name)
        end

        if client.name == "copilot" then
            copilot_active = true
        end
    end

    local list_registered_providers_names = function(filetype)
        local s = require("null-ls.sources")
        local available_sources = s.get_available(filetype)
        local registered = {}
        for _, source in ipairs(available_sources) do
            for method in pairs(source.methods) do
                registered[method] = registered[method] or {}
                table.insert(registered[method], source.name)
            end
        end
        return registered
    end

    function list_registered(filetype)
        local registered_providers = list_registered_providers_names(filetype)
        local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
            return registered_providers[m] or {}
        end, alternative_methods))
        return providers_for_methods
    end

    function formatters_list_registered(filetype)
        local registered_providers = list_registered_providers_names(filetype)
        return registered_providers[null_ls.methods.FORMATTING] or {}
    end

    -- formatters
    local supported_formatters = formatters_list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_formatters)

    -- linters
    local supported_linters = list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_linters)
    local unique_client_names = vim.fn.uniq(buf_client_names)

    local language_servers = "" .. table.concat(unique_client_names, ", ") .. ""

    if copilot_active then
        language_servers = language_servers .. "%#SLCopilot#" .. "    "
    else
        language_servers = language_servers .. "%#SLCopilotInactive#" .. "    "
    end

    return language_servers
end

lualine.setup({
    options = {
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = {
            modes,
        },
        lualine_b = {
            {
                "filetype",
                icon_only = true,
                colored = true,
                padding = { left = 2 },
                color = { bg = colors.orange },
            },
            {
                "filename",
                padding = 1,
                separator = { left = "", right = "" },
                color = { bg = colors.orange, fg = colors.black2, gui = "bold" },
                file_status = true,
                newfile_status = true,
                path = 5,
                symbols = {
                    modified = "●",
                    readonly = "",
                    unnamed = "",
                    newfile = "",
                },
            },
        },
        lualine_c = {
            branch,
            diff,
            {
                function()
                    return " "
                end,
                separator = { left = "", right = "" },
                color = { bg = colors.blue, fg = colors.black },
            }
        },
        lualine_x = {
            {
                function()
                    return " "
                end,
                separator = { left = "", right = "" },
                color = { bg = colors.orange, fg = colors.black },
            },
            diagnostics,
            {
                lsp_progess,
            },
            {
                function()
                    return ""
                end,
                separator = { left = "", right = "" },
                color = { bg = colors.blue, fg = colors.black },
            },
            indent,
            {
                function()
                    return ""
                end,
                separator = { left = "", right = "" },
                color = { bg = colors.orange, fg = colors.black },
            },
            "progress",
            {
                function()
                    return ""
                end,
                separator = { left = "", right = "" },
                color = { bg = colors.blue, fg = colors.black },
            },
            location,
            {
                function()
                    local current_line = vim.fn.line(".")
                    local total_lines = vim.fn.line("$")
                    local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
                    local progress_percent = current_line / total_lines
                    local index = math.ceil(progress_percent * #chars)
                    return chars[index]
                end,
                color = { fg = colors.orange },
            }
        },
        lualine_y = {},
        lualine_z = {},
    },
})
