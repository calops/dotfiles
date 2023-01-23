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
            colors = {
                logo = hr_utils.get_highlight('TablineLogo'),
                tab_active = hr_utils.get_highlight('TablineSel'),
                tab_inactive = hr_utils.get_highlight('Tabline'),
            }
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
        hr_utils.make_tablist({
            init = function(self)
                local devicons = require('nvim-web-devicons')

                self.buffers = {}
                for _, win in ipairs(vim.api.nvim_tabpage_list_wins(self.tabnr)) do
                    local buffer = vim.api.nvim_win_get_buf(win)
                    local buffer_name = vim.api.nvim_buf_get_name(buffer) or ""
                    local file_name = buffer_name:match("^.+/(.+)$")
                    if file_name then
                        local icon, icon_color = devicons.get_icon_color(file_name, file_name:match("^.+%.(.+)$"))
                        table.insert(self.buffers, {
                            nr = buffer,
                            name = file_name,
                            icon = {
                                text = icon,
                                color = icon_color,
                            },
                        })
                    end

                    if not self.tab_name then
                        self.tab_name = file_name
                    end

                    if self.is_active then
                        self.tab_color = self.colors.tab_active
                    else
                        self.tab_color = self.colors.tab_inactive
                    end
                end

                if not self.tab_name then
                    self.tab_name = "[no name]"
                end

                self[1] = self:new(ui_utils.build_pill(
                    {
                    },
                    { text = self.tab_name, hl = self.tab_color },
                    {
                    }
                ), 1)
            end,
            provider = " ",
        }),
    },
}
