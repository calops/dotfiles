local nmap = require("core.utils").nmap
local xmap = require("core.utils").xmap
local omap = require("core.utils").omap

return {
	-- Comment commands
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			require("Comment").setup()
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
			nmap("<leader>pp", function()
				require("debugprint").debugprint()
			end, "Add simple debug print below")
			nmap("<leader>pP", function()
				require("debugprint").debugprint({ above = true })
			end, "Add simple debug print above")
			nmap("<leader>pv", function()
				require("debugprint").debugprint({ variable = true })
			end, "Add variable debug print below")
			nmap("<leader>pV", function()
				require("debugprint").debugprint({ variable = true, above = true })
			end, "Add variable debug print above")

			xmap("<leader>p", function()
				require("debugprint").debugprint({ variable = true })
			end, "Add variable debug print below")
			xmap("<leader>P", function()
				require("debugprint").debugprint({ variable = true, above = true })
			end, "Add variable debug print above")

			omap("<leader>p", function()
				require("debugprint").debugprint({ variable = true })
			end, "Add variable debug print below")
			omap("<leader>P", function()
				require("debugprint").debugprint({ variable = true, above = true })
			end, "Add variable debug print above")
		end,
		config = function()
			require("debugprint").setup({})
		end,
	},
	{
		"andymass/vim-matchup",
        event = "VeryLazy",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
}
