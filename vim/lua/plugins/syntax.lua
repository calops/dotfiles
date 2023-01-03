local nmap = require("core.utils").nmap
return {
	-- Universal language parser
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				ensure_installed = { "vim", "lua", "rust" },
				indent = { enable = true },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						scope_incremental = "<CR>",
						node_incremental = "<TAB>",
						node_decremental = "<S-TAB>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					swap = { enable = true },
					lsp_interop = {
						enable = true,
						border = "rounded",
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
				},
				matchup = {
					enable = true,
				},
				context_commentstring = { enable = true },
				playground = { enable = true },
				query_linter = {
					enable = true,
					use_virtual_text = true,
					lint_events = { "BufWrite", "CursorHold" },
				},
			})
		end,
	},
	-- Textobjects for treesitter elements
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
	},
	-- Show sticky context for off-screen scope beginnings
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		config = function()
			require("treesitter-context").setup({
				enable = true,
				max_lines = 5,
				trim_scope = "outer",
				zindex = 40,
				mode = "cursor",
			})
		end,
	},
	-- Playground treesitter utility
	{
		"nvim-treesitter/playground",
		cmd = "TSHighlightCapturesUnderCursor",
		init = function()
			nmap("<leader>T", ":TSHighlightCapturesUnderCursor<CR>", "Show highlighting groups and captures")
		end,
	},
	-- RON syntax plugin
	{
		"ron-rs/ron.vim",
		ft = "ron",
	},
	-- Syntax-aware text objects and motions
	{
		"ziontee113/syntax-tree-surfer",
		lazy = true,
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
	},
	-- Syntax-aware comments
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "VeryLazy",
	},
}
