local nmap = require("core.utils").nmap

return {
    -- Tabline
    {
        "rafcamlet/tabline-framework.nvim",
        event = "UIEnter",
        config = function()
            local colors = require("catppuccin.palettes").get_palette()
            local highlights = require("tabline_framework.highlights")
            local col_base = highlights.get_hl("TabLineFill")
            local col_active = highlights.get_hl("TabLineSel")
            local col_inactive = highlights.get_hl("TabLine")
            local sep_left = " "
            local sep_right = ""

            require("tabline_framework").setup({
                render = function(f)
                    f.add({ " 裡 ", fg = colors.teal, bg = col_base.bg })

                    f.make_tabs(function(info)
                        local sep_fg
                        if info.current then
                            sep_fg = col_active.bg
                        else
                            sep_fg = col_inactive.bg
                        end
                        f.set_bg(sep_fg)

                        f.add({ sep_left, fg = sep_fg, bg = col_base.bg })
                        f.add(info.index .. " ")

                        if info.filename then
                            f.add(info.modified and "+")
                            f.add(info.filename)
                        else
                            f.add(info.modified and "[+]" or "[-]")
                        end

                        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(info.tab)) do
                            local buffer = vim.api.nvim_win_get_buf(win)
                            local buffer_name = vim.api.nvim_buf_get_name(buffer) or ""
                            local filename = buffer_name:match("^.+/(.+)$")
                            local icon = f.icon(filename)
                            local icon_color = f.icon_color(filename)

                            if icon ~= nil then
                                if info.current and icon_color ~= nil then
                                    f.set_fg(icon_color)
                                end
                                f.add(" " .. icon)
                            end
                        end

                        f.add(" ")

                        f.add({ sep_right, fg = sep_fg, bg = col_base.bg })
                    end)
                end,
            })

            local function new_tab()
                vim.cmd([[
                    let view = winsaveview()
                    tabedit %
                    call winrestview(view)
                ]])
            end

            nmap {
                ["<C-t>"] = { new_tab, "Open current buffer in new tab" },
                ["<C-Tab>"] = { ":tabnext<CR>", "View next tab" },
                ["<C-S-Tab>"] = { ":tabprevious<CR>", "View previous tab" },
            }
        end,
    },
}
