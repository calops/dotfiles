-- Playground treesitter utility
local nmap = require("core.utils").nmap
return {
	"nvim-treesitter/playground",
	cmd = "TSHighlightCapturesUnderCursor",
	init = function()
		nmap("<leader>T", ":TSHighlightCapturesUnderCursor<CR>", "Show highlighting groups and captures")
	end,
}
