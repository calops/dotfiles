-- Code definition and references peeking
local nmap = require("core.utils").nmap
return {
	"dnlhc/glance.nvim",
	cmd = "Glance",
	init = function()
		nmap("gd", "<CMD>Glance definitions<CR>", "Peek definition(s)")
		nmap("gr", "<CMD>Glance references<CR>", "Peek references")
		nmap("gD", "<CMD>Glance type_definitions<CR>", "Peek declarations")
		nmap("gi", "<CMD>Glance implementations<CR>", "Peek implementations")
	end,
	config = function()
		require("glance").setup({
			height = 25,
			border = { enable = true },
			theme = { enable = true, mode = "auto" },
		})
	end,
}
