local module = {}

local function map_with_mode(mode)
	return function (mappings, opts_in)
		local wk = require("which-key")
		local opts = vim.tbl_extend("force", opts_in or {}, { mode = mode })
		return wk.register(mappings, opts)
	end
end

module.nmap = map_with_mode("n")
module.imap = map_with_mode("i")
module.xmap = map_with_mode("x")
module.vmap = map_with_mode("v")
module.omap = map_with_mode("o")

return module
