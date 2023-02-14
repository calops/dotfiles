local nmap = require("core.utils").nmap
local xmap = require("core.utils").xmap
local omap = require("core.utils").omap

return {
	-- Comment commands
	{
		'echasnovski/mini.comment',
		event = "VeryLazy",
		config = function()
			require('mini.comment').setup()
		end,
	},
	-- Automatically adjust indentation settings depending on the file
	{
		"nmac427/guess-indent.nvim",
		event = "InsertEnter",
		config = function()
			require("guess-indent").setup({})
		end,
	},
	-- Structural replace
	{
		"cshuaimin/ssr.nvim",
		lazy = true,
		init = function()
			vim.keymap.set({ "n", "x" }, "<leader>cR", function()
				require("ssr").open()
			end, { desc = "Structural replace" })
		end,
	},
	-- Surround text objects
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	-- Word families substitutions
	{
		"tpope/vim-abolish",
		event = "VeryLazy",
	},
	-- Debug print statements
	{
		"andrewferrier/debugprint.nvim",
		lazy = true,
		init = function()
			nmap {
				["<leader>p"] = {
					name = "debug print",
					p = { function() require("debugprint").debugprint() end, "Add simple debug print below" },
					P = { function() require("debugprint").debugprint { above = true } end, "Add simple debug print above" },
					v = { function() require("debugprint").debugprint { variable = true } end, "Add variable debug print below" },
					V = { function() require("debugprint").debugprint { variable = true, above = true } end,
						"Add variable debug print above" },
				}
			}

			xmap {
				["<leader>p"] = { function() require("debugprint").debugprint { variable = true } end,
					"Add variable debug print below" },
				["<leader>P"] = { function() require("debugprint").debugprint { variable = true, above = true } end,
					"Add variable debug print above" },
			}

			omap {
				["<leader>p"] = { function() require("debugprint").debugprint { variable = true } end,
					"Add variable debug print below" },
				["<leader>P"] = { function() require("debugprint").debugprint { variable = true, above = true } end,
					"Add variable debug print above" },
			}
		end,
		config = function()
			require("debugprint").setup({})
		end,
	},
	-- Navigate over sets of matching pairs
	{
		"andymass/vim-matchup",
		event = "VeryLazy",
		enabled = false,
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	-- Edit filesystem as a buffer
	{
		'stevearc/oil.nvim',
		config = function()
			require('oil').setup()
		end
	},
	-- Move stuff around
	{
		'echasnovski/mini.move',
		event = "VeryLazy",
		config = function()
			require('mini.move').setup { mappings = {
                left = '<S-Left>',
				right = '<S-Right>',
				down = '<S-Down>',
				up = '<S-Up>',

				line_left = '<S-Left>',
				line_right = '<S-Right>',
				line_down = '<S-Down>',
				line_up = '<S-Up>',
			},
			}
		end,
	},
}
