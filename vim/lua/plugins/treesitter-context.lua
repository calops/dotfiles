-- Show sticky context for off-screen scope beginnings
return {
	"nvim-treesitter/nvim-treesitter-context",
	event = "VeryLazy",
	config = function()
		require("treesitter-context").setup({
			enable = true,
			max_lines = 5,
			trim_scope = "outer",
			zindex = 40,
			mode = "cursor",
		})
	end,
}
