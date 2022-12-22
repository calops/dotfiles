-- Keymaps cheat sheet and tooltips
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		require("which-key").setup({
			window = {
				border = "rounded",
				position = "bottom", -- bottom, top
				winblend = 20,
			},
		})
	end,
}
