return {
	"b0o/incline.nvim",
	lazy = false,
	config = function()
		local incline = require("incline")
		local highlights = require("tabline_framework.highlights")
		local utils = require("catppuccin.utils.colors")
		local col_inactive = highlights.get_hl("InclineNormalNC")
		local col_active = highlights.get_hl("InclineNormal")
		local col_base = highlights.get_hl("Normal")
		local diag_colors = {
			highlights.get_hl("DiagnosticVirtualTextError"),
			highlights.get_hl("DiagnosticVirtualTextWarn"),
			highlights.get_hl("DiagnosticVirtualTextInfo"),
			highlights.get_hl("DiagnosticVirtualTextHint"),
		}

		incline.setup({
			render = function(props)
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":.")
				local extension = filename:match("^.+%.(.+)$")
				local icon, icon_fg_color =
					require("nvim-web-devicons").get_icon_colors(filename, extension, { default = true })

				local icon_color = {
					fg = icon_fg_color,
					bg = utils.darken(icon_fg_color, 0.3),
				}

				local color = col_inactive
				if props.focused then
					color = col_active
				end

				local result = {
					{ "", guifg = icon_color.bg, guibg = col_base.bg },
					{ icon .. " ", guifg = icon_color.fg, guibg = icon_color.bg },
					{ "", guifg = color.bg, guibg = icon_color.bg },
					{ filename },
				}

				local lsp_diagnostics = vim.diagnostic.get(props.buf)
				local diag_counts = { 0, 0, 0, 0 }

				for _, diag in ipairs(lsp_diagnostics) do
					diag_counts[diag.severity] = diag_counts[diag.severity] + 1
				end

				local prev_color = color
				for i = 1, 4 do
					if diag_counts[i] > 0 then
						table.insert(result, { "", guifg = prev_color.bg, guibg = diag_colors[i].bg })
						table.insert(
							result,
							{ " " .. diag_counts[i], guifg = diag_colors[i].fg, guibg = diag_colors[i].bg }
						)
						prev_color = diag_colors[i]
					end
				end

				table.insert(result, { "", guifg = prev_color.bg, guibg = col_base.bg })

				return result
			end,
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
