-- LSP bridge for non-LSP utilities
return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "VeryLazy",
	config = function()
		local nls = require("null-ls")
		nls.setup({
			sources = { nls.builtins.formatting.stylua, nls.builtins.diagnostics.buf },
		})
	end,
}
