-- Universal clipboard forwarding
local nmap = require("core.utils").nmap
local xmap = require("core.utils").xmap
return {
	"ojroques/nvim-osc52",
	event = "VeryLazy",
	config = function()
		local osc52 = require("osc52")

		nmap("<leader>c", osc52.copy_operator, "Copy to clipboard", { expr = true })
		nmap("<leader>cc", "<leader>c_", "Copy line to clipboard", { remap = true })
		xmap("<leader>c", osc52.copy_visual, "Copy selection to clipboard")

		vim.api.nvim_create_autocmd("TextYankPost", {
			callback = function()
				if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
					require("osc52").copy_register("+")
				end
			end,
		})
	end,
}
