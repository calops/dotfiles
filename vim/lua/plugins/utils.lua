local nmap = require("core.utils").nmap
local xmap = require("core.utils").xmap
local imap = require("core.utils").imap
return {
	-- Session management
	{
		"rmagatti/auto-session",
		lazy = false,
		config = function()
			require("auto-session").setup({
				log_level = "error",
				cwd_change_handling = false,
				bypass_session_save_file_types = { "neo-tree" },
				pre_save_cmds = {
					function()
						require("neo-tree.sources.manager").close_all()
					end,
				},
			})
		end,
	},
	-- Firefox integration
	{
		"glacambre/firenvim",
		lazy = false,
		build = function()
			vim.fn["firenvim#install"](0)
		end,
	},
	-- Universal clipboard forwarding
	{
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
	},
	-- Startup time analyzer
	{
		"dstein64/vim-startuptime",
		lazy = false,
		enabled = false,
	},
	-- Floating terminal window
	{
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
				},
				highlights = {
					FloatBorder = { link = "TermFloatBorder" },
				},
			})
			vim.cmd(
				[[autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-f> <Cmd>exe v:count1 . "ToggleTerm"<CR>]]
			)
		end,
	},
	-- Support for local settings
	{
		"folke/neoconf.nvim",
		lazy = false,
		config = function()
			require("neoconf").setup({})
		end,
	},
}
