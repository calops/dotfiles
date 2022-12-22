-- Git utilities, gutter signs
return {
	"tanvirtin/vgit.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = "VeryLazy",
	config = function()
		require("vgit").setup({
			settings = {
				live_gutter = { enabled = true },
				live_blame = { enabled = false },
			},
		})
	end,
}
