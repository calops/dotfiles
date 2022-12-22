-- IDE panels
local nmap = require("core.utils").nmap
return {
	"ldelossa/nvim-ide",
	cmd = "Workspace",
	init = function()
		nmap("<leader>wl", ":Workspace LeftPanelToggle<CR>", "Toggle git panels")
		nmap("<leader>wr", ":Workspace RightPanelToggle<CR>", "Toggle IDE panels")
	end,
	config = function()
		require("ide").setup({
			workspaces = {
				auto_open = "none",
			},
			panel_sizes = {
				left = 60,
				right = 60,
				bottom = 15,
			},
		})
	end,
}
