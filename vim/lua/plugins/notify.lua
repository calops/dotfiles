-- Notification handler
return {
	"rcarriga/nvim-notify",
	lazy = false,
	config = function()
		require("notify").setup({
			top_down = true,
			max_width = 100,
		})
	end,
}
