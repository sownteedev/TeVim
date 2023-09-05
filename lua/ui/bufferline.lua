local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

bufferline.setup({
    options = {
        mode = "buffers",
        numbers = "ordinal",
        close_command = "bd! %d",
        right_mouse_command = "bd! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
            icon = "▍",
            -- icon = "|",
            style = "icon",
        },
        buffer_close_icon = "󰅙",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        truncate_names = true,
        max_name_length = 20,
        max_prefix_length = 20,
        tab_size = 20,
        diagnostics = false,
        diagnostics_update_in_insert = true,
        offsets = {},
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_duplicate_prefix = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thin",
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        hover = {
            enabled = true,
            delay = 0,
            reveal = { 'close' }
        }
    }
})

local Offset = require("bufferline.offset")
if not Offset.edgy then
    local get = Offset.get
    Offset.get = function()
        if package.loaded.edgy then
            local layout = require("edgy.config").layout
            local ret = { left = "", left_size = 0, right = "", right_size = 0 }
            for _, pos in ipairs({ "left", "right" }) do
                local sb = layout[pos]
                if sb and #sb.wins > 0 then
                    local title = "                          " .. string.rep(" ", sb.bounds.width - 26)
                    ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#%*"
                    ret[pos .. "_size"] = sb.bounds.width
                end
            end
            ret.total_size = ret.left_size + ret.right_size
            if ret.total_size > 0 then
                return ret
            end
        end
        return get()
    end
    Offset.edgy = true
end
