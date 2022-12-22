-- Status line
return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
				section_separators = { right = "", left = "" },
				component_separators = { right = "", left = "" },
			},
		})
	end,
}
