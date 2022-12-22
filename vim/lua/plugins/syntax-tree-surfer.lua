-- Syntax-aware text objects and motions
local nmap = require("core.utils").nmap
return {
	"ziontee113/syntax-tree-surfer",
	init = function()
		local function dot_repeatable(op)
			return function()
				require("syntax-tree-surfer")
				vim.opt.opfunc = op
				return "g@l"
			end
		end

		nmap("vu", dot_repeatable("v:lua.STSSwapUpNormal_Dot"), "Swap object upwards", { expr = true })
		nmap("vd", dot_repeatable("v:lua.STSSwapDownNormal_Dot"), "Swap object downwards", { expr = true })
		nmap("vD", dot_repeatable("v:lua.STSSwapCurrentNodeNextNormal_Dot"), "Swap node backwards", { expr = true })
		nmap("vU", dot_repeatable("v:lua.STSSwapCurrentNodePrevNormal_Dot"), "Swap node forwards", { expr = true })
	end,
}
