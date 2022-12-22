-- Floating terminal window
local nmap = require("core.utils").nmap
local imap = require("core.utils").imap
return {
	"akinsho/toggleterm.nvim",
	name = "toggleterm",
	cmd = "ToggleTerm",
	init = function()
		nmap("<C-f>", "<Cmd>exe v:count1 . 'ToggleTerm'<CR>", "Toggle floating terminal")
		imap("<C-f>", "<Esc><Cmd>exe v:count1 . 'ToggleTerm'<CR>", "Toggle floating terminal")
	end,
	config = function()
		require("toggleterm").setup({
			direction = "float",
			float_opts = {
				border = "rounded",
				winblend = 10,
			},
			highlights = {
				FloatBorder = { link = "TermFloatBorder" },
			},
		})
		vim.cmd([[autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-f> <Cmd>exe v:count1 . "ToggleTerm"<CR>]])
	end,
}
