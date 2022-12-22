-- Context-aware indentation lines
return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require("indent_blankline").setup({
			show_current_context = true,
			show_current_context_start = false,
			use_treesitter = true,
			max_indent_increase = 1,
			show_trailing_blankline_indent = false,
			integrations = {
				neotree = {
					enabled = true,
					show_root = false,
					transparent_panel = false,
				},
			},
		})
	end,
}
