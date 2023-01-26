local hr_utils = require('heirline.utils')
local ui_utils = require('plugins.ui.utils')

return {
    init = function(self)
        self.tabpages = vim.api.nvim_list_tabpages()
    end,
    {
        condition = function(self)
            return not vim.tbl_isempty(self.tabpages)
        end,
        static = {
            sep = ui_utils.separators,
            diags = ui_utils.diags_sorted(),
            colors = {
                logo = hr_utils.get_highlight('TablineLogo'),
                tab_active = hr_utils.get_highlight('TablineSel'),
                tab_inactive = hr_utils.get_highlight('Tabline'),
                icon_pill = hr_utils.get_highlight('TablineIconPill'),
                icon_modified = hr_utils.get_highlight('TablineModifiedIcon'),
            }
        },
        {
            provider = "%=",
        },
        -- Logo
        {
            hr_utils.surround(
                {
                    function(self) return self.sep.left end,
                    function(self) return self.sep.right .. " " end
                },
                function(self) return self.colors.logo.bg end,
                {
                    provider = " Tabs",
                    hl = 'TablineLogo',
                }
            )
        },
        -- Tabs
        ui_utils.make_tablist({
            init = function(self)
                local devicons = require('nvim-web-devicons')
                local function compute_icon_color(color)
                    if self.is_active then
                        return color
                    end
                    return ui_utils.darken(color, 0.4, string.format("#%x", self.colors.icon_pill.bg))
                end

                local icons = {}
                local diag_count = { 0, 0, 0, 0 }
                local modified = false
                self.tab_name = nil
                self.wins = vim.api.nvim_tabpage_list_wins(self.tabpage)
                for _, win in ipairs(self.wins) do
                    local buffer = vim.api.nvim_win_get_buf(win)
                    local buffer_name = vim.api.nvim_buf_get_name(buffer) or ""
                    local file_name = buffer_name:match("^.+/(.+)$")
                    if file_name then
                        local icon, icon_color = devicons.get_icon_color(file_name, file_name:match("^.+%.(.+)$"))
                        if icon and icon_color then
                            table.insert(icons, {
                                provider = icon .. " ",
                                hl = { fg = compute_icon_color(icon_color) },
                            })
                        end
                    end

                    diag_count = ui_utils.diag_count_for_buffer(buffer, diag_count)

                    if not self.tab_name then
                        self.tab_name = file_name
                    end

                    if self.is_active then
                        self.tab_color = self.colors.tab_active
                    else
                        self.tab_color = self.colors.tab_inactive
                    end

                    if vim.api.nvim_buf_get_option(buffer, "modified") then
                        modified = true
                    end
                end

                local diag_pills = {}
                local first = true
                for i, count in ipairs(diag_count) do
                    if count > 0 then
                        if first then
                            table.insert(diag_pills, { provider = " " })
                            first = false
                        end
                        table.insert(diag_pills, {
                            provider = self.diags[i].sign,
                            hl = { fg = compute_icon_color(string.format("#%x", self.diags[i].colors.fg)) },
                        })
                    end
                end

                if not self.tab_name then
                    self.tab_name = "[no name]"
                end

                self[1] = self:new({ provider = "%" .. self.tabnr .. "T" }, 1)
                self[2] = self:new(ui_utils.build_pill(
                    {
                        { hl = self.colors.icon_pill, icons },
                    },
                    {
                        hl = self.tab_color,
                        {
                            { provider = self.tabpage .. " ", hl = "TablineNumber" },
                            { provider = self.tab_name },
                        }
                    },
                    {
                        {
                            hl = self.colors.icon_pill,
                            condition = function() return not vim.tbl_isempty(diag_pills) end,
                            diag_pills
                        },
                        {
                            provider = "  ",
                            condition = function() return modified end,
                            hl = { fg = self.colors.icon_modified.fg }
                        },
                    }
                ), 2)
                self[3] = self:new({ provider = "%T" }, 3)
            end,
            provider = " ",
        }),
        {
            provider = "%=",
        },
    },
}
