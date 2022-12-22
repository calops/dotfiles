-- Firefox integration
return {
	"glacambre/firenvim",
	lazy = false,
	build = function()
		vim.fn["firenvim#install"](0)
	end,
}
