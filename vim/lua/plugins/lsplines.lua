-- Show rich inline diagnostics
local nmap = require("core.utils").nmap
return {
	url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	init = function()
		local function toggle_virtual_lines()
			local is_enabled = vim.diagnostic.config().virtual_lines

			vim.diagnostic.config({
				virtual_lines = not is_enabled,
				virtual_text = is_enabled,
			})
		end

		nmap("<leader>m", function()
			require("lsp_lines")
			toggle_virtual_lines()
		end, "Toggle full inline diagnostics")
	end,
	config = function()
		require("lsp_lines").setup()

		vim.diagnostic.config({
			signs = true,
			severity_sort = true,
			virtual_lines = false,
		})
	end,
}
