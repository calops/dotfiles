local module = {}

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

module.separators = {
    left = "",
    right = "",
}

function module.darken(color, amount, bg)
    return require('catppuccin.utils.colors').darken(color, amount, bg)
end

function module.build_pill(left, center, right)
    local colors = module.colors()
    local sep = module.separators
    local result = {
        insert = function(self, item, hl)
            table.insert(self.content, { provider = item, hl = hl })
        end,
        content = {},
    }
    local function bg(color)
        if not color.bg then
            color.bg = module.darken(string.format("#%x", color.fg), 0.3)
        end
        return color.bg
    end

    local prev_color = colors.normal
    for _, item in ipairs(left) do
        result:insert(sep.left, { fg = bg(item.hl), bg = bg(prev_color) })
        result:insert(item.text, item.hl)
        prev_color = item.hl
    end

    result:insert(sep.left, { fg = bg(center.hl), bg = bg(prev_color) })
    result:insert(center.text, center.hl)
    prev_color = center.hl

    for _, item in ipairs(right) do
        result:insert(sep.right, { fg = bg(prev_color), bg = bg(item.hl) })
        result:insert(item.text, item.hl)
        prev_color = item.hl
    end

    result:insert(sep.right, { fg = bg(prev_color), bg = bg(colors.normal) })

    return result.content
end

return module
