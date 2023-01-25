return {
    "b0o/incline.nvim",
    event = "UIEnter",
    config = function()
        local function format_color(color)
            return string.format("#%x", color)
        end

        local incline = require("incline")
        local color_utils = require("catppuccin.utils.colors")
        local hr_utils = require('heirline.utils')
        local col_inactive = format_color(hr_utils.get_highlight("InclineNormalNC").bg)
        local col_active = format_color(hr_utils.get_highlight("InclineNormal").bg)
        local col_base = format_color(hr_utils.get_highlight("Normal").bg)
        local diags = require('plugins.ui.utils').diags_sorted()

        incline.setup({
            render = function(props)
                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":.")
                local extension = filename:match("^.+%.(.+)$")
                local icon, icon_fg_color = require("nvim-web-devicons").get_icon_colors(filename, extension,
                    { default = true })

                local icon_color = {
                    fg = icon_fg_color,
                    bg = color_utils.darken(icon_fg_color, 0.3),
                }

                local color = col_inactive
                if props.focused then
                    color = col_active
                end

                local result = {
                    { "", guifg = icon_color.bg, guibg = col_base },
                    { icon .. " ", guifg = icon_color.fg, guibg = icon_color.bg },
                    { "", guifg = color, guibg = icon_color.bg },
                    { filename },
                }

                local diag_counts = require('plugins.ui.utils').diag_count_for_buffer(props.buf)
                local prev_color = color

                for i, count in ipairs(diag_counts) do
                    if count > 0 then
                        table.insert(result, { "", guifg = prev_color, guibg = format_color(diags[i].colors.bg) })
                        table.insert(result, {
                            " " .. diags[i].sign .. count,
                            guifg = format_color(diags[i].colors.fg),
                            guibg = format_color(diags[i].colors.bg),
                        })
                        prev_color = format_color(diags[i].colors.bg)
                    end
                end

                table.insert(result, { "", guifg = prev_color, guibg = col_base })

                return result
            end,
            hide = { cursorline = true },
            window = {
                zindex = 100,
                padding = 0,
                placement = { horizontal = "right", vertical = "top" },
                margin = {
                    horizontal = { left = 1, right = 1 },
                    vertical = { bottom = 1, top = 0 },
                },
            },
        })
    end,
}
