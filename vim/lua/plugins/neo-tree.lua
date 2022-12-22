local nmap = require("core.utils").nmap

-- File tree browser
return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"kyazdani42/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	init = function()
		nmap("<leader>nn", ":Neotree toggle reveal_force_cwd<cr>", "Toggle file browser")
		nmap("<leader>ng", ":Neotree float git_status<cr>", "Show git status")
	end,
	config = function()
		require("neo-tree").setup({
			popup_border_style = "rounded",
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,
				},
			},
		})
	end,
}
