local module = {}

require('catppuccin') -- Make sure the theme is loaded first
local utils = require('heirline.utils')

module._colors_data = nil
function module.colors()
    if not module._colors_data then
        module._colors_data = {
            normal = utils.get_highlight('Normal'),
        }
    end
    return module._colors_data
end

module._git_data = nil
function module.git()
    if not module._git_data then
        module._git_data =
        {
            add = {
                colors = utils.get_highlight('GitSignsAdd'),
            },
            change = {
                colors = utils.get_highlight('GitSignsChange'),
            },
            delete = {
                colors = utils.get_highlight('GitSignsDelete'),
            },
            untracked = {
                colors = utils.get_highlight('GitSignsAdd'),
            },
            changedelete = {
                colors = utils.get_highlight('GitSignsChangedelete'),
            },
        }
    end
    return module._git_data
end

function module.git_signs()
    return {
        GitSignsAdd = module.git().add,
        GitSignsChange = module.git().change,
        GitSignsDelete = module.git().delete,
        GitSignsUntracked = module.git().untracked,
        GitSignsChangedelete = module.git().changedelete,
    }
end

module._diags_data = nil
function module.diags()
    if not module._diags_data then
        module._diags_data = {
            error = {
                severity = 1,
                colors = utils.get_highlight('DiagnosticVirtualTextError'),
                sign = vim.fn.sign_getdefined('DiagnosticSignError')[1].text
            },
            warn = {
                severity = 2,
                colors = utils.get_highlight('DiagnosticVirtualTextWarn'),
                sign = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text
            },
            info = {
                severity = 3,
                colors = utils.get_highlight('DiagnosticVirtualTextInfo'),
                sign = vim.fn.sign_getdefined('DiagnosticSignInfo')[1].text
            },
            hint = {
                severity = 4,
                colors = utils.get_highlight('DiagnosticVirtualTextHint'),
                sign = vim.fn.sign_getdefined('DiagnosticSignHint')[1].text
            },
        }
    end
    return module._diags_data
end

function module.diags_signs()
    return {
        DiagnosticSignError = module.diags().error,
        DiagnosticSignWarn = module.diags().warn,
        DiagnosticSignInfo = module.diags().info,
        DiagnosticSignHint = module.diags().hint,
    }
end

function module.diags_sorted()
    return {
        module.diags().error,
        module.diags().warn,
        module.diags().info,
        module.diags().hint,
    }
end

function module.diags_lines()
    return {
        'DiagnosticLineError',
        'DiagnosticLineWarn',
        'DiagnosticLineInfo',
        'DiagnosticLineHint',
    }
end

function module.diags_underlines()
    return {
        'DiagnosticUnderlineError',
        'DiagnosticUnderlineWarn',
        'DiagnosticUnderlineInfo',
        'DiagnosticUnderlineHint',
    }
end

module.separators = {
    left = "",
    right = "",
}

function module.darken(color, amount, bg)
    return require('catppuccin.utils.colors').darken(color, amount, bg)
end

function module.brighten(color, amount, bg)
    return require('catppuccin.utils.colors').brighten(color, amount, bg)
end

function module.build_pill(left, center, right)
    local colors = module.colors()
    local sep = module.separators
    local result = {
        insert = function(self, item)
            table.insert(self.content, item)
        end,
        content = {},
    }
    local function bg(color)
        if not color then
            color = {}
        end
        if not color.bg then
            color.bg = module.darken(string.format("#%x", color.fg), 0.3)
        end
        return color.bg
    end

    local prev_color = colors.normal
    for _, item in ipairs(left) do
        if not item.condition or item.condition() then
            result:insert({ provider = sep.left, hl = { fg = bg(item.hl), bg = bg(prev_color) } })
            result:insert(item)
            prev_color = item.hl
        end
    end

    result:insert({ provider = sep.left, hl = { fg = bg(center.hl), bg = bg(prev_color) } })
    result:insert(center)
    prev_color = center.hl

    for _, item in ipairs(right) do
        if not item.condition or item.condition() then
            result:insert({ provider = sep.right, hl = { fg = bg(prev_color), bg = bg(item.hl) } })
            result:insert(item)
            prev_color = item.hl
        end
    end

    result:insert({ provider = sep.right, hl = { fg = bg(prev_color), bg = bg(colors.normal) } })

    return result.content
end

function module.diag_count_for_buffer(bufnr, diag_count)
    if not diag_count then
        diag_count = { 0, 0, 0, 0 }
    end

    for _, diag in ipairs(vim.diagnostic.get(bufnr)) do
        diag_count[diag.severity] = diag_count[diag.severity] + 1
    end

    return diag_count
end

function module.make_tablist(tab_component)
    local tablist = {
        init = function(self)
            local tabpages = vim.api.nvim_list_tabpages()
            for i, tabpage in ipairs(tabpages) do
                local tabnr = vim.api.nvim_tabpage_get_number(tabpage)
                local child = self[i]
                if not (child and child.tabpage == tabpage) then
                    self[i] = self:new(tab_component, i)
                    child = self[i]
                    child.tabnr = tabnr
                    child.tabpage = tabpage
                end
                if tabpage == vim.api.nvim_get_current_tabpage() then
                    child.is_active = true
                    self.active_child = i
                else
                    child.is_active = false
                end
            end
            if #self > #tabpages then
                for i = #self, #tabpages + 1, -1 do
                    self[i] = nil
                end
            end
        end,
    }
    return tablist
end

return module
