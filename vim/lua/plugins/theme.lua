-- Theme
return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	config = function()
		vim.g.catppuccin_flavour = "mocha"
		require("catppuccin").setup({
			integrations = {
				telescope = true,
				neotree = {
					enabled = true,
					show_root = true,
					transparent_panel = false,
				},
				indent_blankline = {
					enabled = false,
					colored_indent_levels = false,
				},
			},
			compile = {
				enabled = true,
			},
			custom_highlights = function()
				local colors = require("catppuccin.palettes").get_palette()
				local utils = require("catppuccin.utils.colors")

				return {
					NormalFloat = { bg = colors.base },
					FloatBorder = { fg = colors.mauve },
					TermFloatBorder = { fg = colors.red },

					TelescopeBorder = { fg = colors.yellow },
					TelescopePromptBorder = { fg = colors.peach },
					TelescopePreviewBorder = { fg = colors.teal },
					TelescopeResultsBorder = { fg = colors.green },

					InclineNormalNC = { bg = colors.surface1, fg = colors.base, blend = 0 },
					InclineNormal = { bg = colors.overlay1, fg = colors.base, blend = 0 },

					TreesitterContext = { bg = colors.base, style = { "italic" }, blend = 0 },
					TreesitterContextLineNumber = {
						fg = colors.surface1,
						bg = colors.mantle,
						style = { "italic" },
						blend = 0,
					},
					TreesitterContextBottom = { sp = colors.crust, style = { "underline" } },

					DiagnosticUnderlineError = { sp = colors.red, style = { "undercurl" } },
					DiagnosticUnderlineWarn = { sp = colors.yellow, style = { "undercurl" } },
					DiagnosticUnderlineInfo = { sp = colors.sky, style = { "undercurl" } },
					DiagnosticUnderlineHint = { sp = colors.teal, style = { "undercurl" } },

					IndentBlanklineChar = { style = { "nocombine" } },
					IndentBlanklineSpaceChar = { style = { "nocombine" } },
					IndentBlanklineContextChar = { fg = colors.mauve, style = { "nocombine" } },
					IndentBlanklineContextSpaceChar = { style = { "nocombine" } },
					IndentBlanklineSpaceCharBlankline = { style = { "nocombine" } },

					ModesInsert = { bg = colors.green },
					ModesVisual = { bg = colors.mauve },

					InlayHints = { fg = colors.surface1 },
					Comment = { fg = utils.darken(colors.lavender, 0.6) },

					IlluminatedWordText = { bg = colors.surface1, style = { "bold", "underdotted" } },
					IlluminatedWordWrite = { bg = colors.surface1, style = { "bold", "underdotted" } },
					IlluminatedWordRead = { bg = colors.surface1, style = { "bold", "underdotted" } },

					["@namespace"] = { fg = colors.maroon },
					["@parameter"] = { fg = colors.pink, style = { "italic" } },
					["@variable"] = { fg = colors.pink },
					["@keyword"] = { fg = colors.mauve, style = { "bold" } },
					["@keyword.function"] = { link = "@keyword" },

					UfoVirtText = { fg = colors.teal, style = { "bold" } },
				}
			end,
		})
		vim.cmd("colorscheme catppuccin")
	end,
}
