-- Diagnostics window

local nmap = require("core.utils").nmap
return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	init = function()
		nmap("<leader>t", function()
			require("trouble").toggle()
		end, "Open diagnostics window")
	end,
	config = function()
		require("trouble").setup({})
	end,
}
