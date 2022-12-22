-- Structural replace
return {
	"cshuaimin/ssr.nvim",
	init = function()
		vim.keymap.set({ "n", "x" }, "<leader>cR", function()
			require("ssr").open()
		end, { desc = "Structural replace" })
	end,
}
