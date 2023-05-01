local nmap = require("core.utils").nmap
local imap = require("core.utils").imap
return {
	-- Session management
	{
		"rmagatti/auto-session",
		lazy = false,
		config = function()
			require("auto-session").setup {
				log_level = "error",
				cwd_change_handling = false,
				bypass_session_save_file_types = { "neo-tree" },
				pre_save_cmds = {
					function()
						require("neo-tree.sources.manager").close_all()
					end,
				},
			}

			nmap {
				["<C-s>"] = {
					require("auto-session.session-lens").search_session,
					"Search sessions",
				},
			}
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
		lazy = true,
		init = function()
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
			nmap { ["<C-f>"] = { "<Cmd>exe v:count1 . 'ToggleTerm'<CR>", "Toggle floating terminal" } }
			imap { ["<C-f>"] = { "<Esc><Cmd>exe v:count1 . 'ToggleTerm'<CR>", "Toggle floating terminal" } }
		end,
		config = function()
			require("toggleterm").setup {
				direction = "float",
				float_opts = {
					border = "rounded",
				},
				highlights = {
					FloatBorder = { link = "TermFloatBorder" },
				},
			}
			vim.cmd(
				[[autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-f> <Cmd>exe v:count1 . "ToggleTerm"<CR>]]
			)
		end,
	},
	-- Project-local configuration
	{
		"folke/neoconf.nvim",
		lazy = false,
		enabled = true,
		config = function()
			require("neoconf").setup()
		end,
	},
	-- Handle nested neovim sessions
	{
		"willothy/flatten.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {
			callbacks = {
				pre_open = function()
					require("toggleterm").toggle(0)
				end,
				post_open = function(bufnr, winnr, ft)
					if ft == "gitcommit" then
						vim.api.nvim_create_autocmd("BufWritePost", {
							buffer = bufnr,
							once = true,
							callback = function()
								vim.defer_fn(function()
									vim.api.nvim_buf_delete(bufnr, {})
								end, 50)
							end,
						})
					else
						require("toggleterm").toggle(0)
						vim.api.nvim_set_current_win(winnr)
					end
				end,
				block_end = function()
					require("toggleterm").toggle(0)
				end,
			},
		},
	},
}
