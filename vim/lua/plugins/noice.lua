-- CMD line replacement and other UI niceties
local nmap = require("core.utils").nmap
return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	lazy = false,
	config = function()
		require("noice").setup({
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				lsp_doc_border = true,
			},
			views = {
				messages = { backend = "popup" },
			},
			popupmenu = { enabled = true, backend = "nui" },
			routes = {
				{
					view = "notify",
					filter = { event = "msg_show", find = '"*"*lines --*%--' },
					opts = { skip = true },
				},
			},
		})
		nmap("<leader><leader>", ":noh<CR>", "Hide search highlights")
	end,
}
