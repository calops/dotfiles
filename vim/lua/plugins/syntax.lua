local nmap = require("core.utils").nmap
local xmap = require("core.utils").xmap

return {
	-- Universal language parser
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
		},
		config = function()
			require("nvim-treesitter.configs").setup {
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
							["af"] = { query = "@function.outer", desc = "outer function" },
							["if"] = { query = "@function.inner", desc = "inner function" },
							["ac"] = { query = "@class.outer", desc = "outer class" },
							["ic"] = { query = "@class.inner", desc = "inner class" },
							["an"] = { query = "@parameter.outer", desc = "outer parameter" },
							["in"] = { query = "@parameter.inner", desc = "inner parameter" },
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
			}
			nmap {
				["<leader>T"] = { ":Inspect<CR>", "Show highlighting groups and captures" },
			}
		end,
	},
	-- Show sticky context for off-screen scope beginnings
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		config = function()
			require("treesitter-context").setup {
				enable = true,
				max_lines = 5,
				trim_scope = "outer",
				zindex = 40,
				mode = "cursor",
			}
		end,
	},
	-- Playground treesitter utility
	{
		"nvim-treesitter/playground",
		cmd = "TSPlaygroundToggle",
	},
	-- RON syntax plugin
	{
		"ron-rs/ron.vim",
		ft = "ron",
	},
	-- Syntax-aware text objects and motions
	{
		"ziontee113/syntax-tree-surfer",
		event = "VeryLazy",
		init = function()
			local function dot_repeatable(op)
				return function()
					vim.opt.opfunc = op
					return "g@l"
				end
			end

			nmap {
				["<M-Up>"] = { dot_repeatable("v:lua.STSSwapUpNormal_Dot"), "Swap node upwards", expr = true },
				["<M-Down>"] = { dot_repeatable("v:lua.STSSwapDownNormal_Dot"), "Swap node downwards", expr = true },
				["<M-Left>"] = {
					dot_repeatable("v:lua.STSSwapCurrentNodePrevNormal_Dot"),
					"Swap with previous node",
					expr = true,
				},
				["<M-Right>"] = {
					dot_repeatable("v:lua.STSSwapCurrentNodeNextNormal_Dot"),
					"Swap with next node",
					expr = true,
				},
				["gO"] = {
					function()
						require("syntax-tree-surfer").go_to_top_node_and_execute_commands(false, {
							"normal! O",
							"normal! O",
							"startinsert",
						})
					end,
					"Insert above top-level node",
				},
				["go"] = {
					function()
						require("syntax-tree-surfer").go_to_top_node_and_execute_commands(true, {
							"normal! o",
							"normal! o",
							"startinsert",
						})
					end,
					"Insert below top-level node",
				},
				["gh"] = { "<CMD>STSSwapOrHold<CR>", "Hold or swap with held node" },
				["<Tab>"] = { "<CMD>STSSelectCurrentNode<CR>", "Select current node" },
			}

			xmap {
				["<M-Up>"] = { "<CMD>STSSwapPrevVisual<CR>", "Swap with previous node" },
				["<M-Down>"] = { "<CMD>STSSwapNextVisual<CR>", "Swap with next node" },
				["<M-Left>"] = { "<CMD>STSSwapPrevVisual<CR>", "Swap with previous node" },
				["<M-Right>"] = { "<CMD>STSSwapNextVisual<CR>", "Swap with next node" },
				["<C-Up>"] = { "<CMD>STSSelectPrevSiblingNode<CR>", "Select previous sibling" },
				["<C-Down>"] = { "<CMD>STSSelectNextSiblingNode<CR>", "Select next sibling" },
				["<C-Left>"] = { "<CMD>STSSelectPrevSiblingNode<CR>", "Select previous sibling" },
				["<C-Right>"] = { "<CMD>STSSelectNextSiblingNode<CR>", "Select next sibling" },
				["<Tab>"] = { "<CMD>STSSelectParentNode<CR>", "Select parent node" },
				["<S-Tab>"] = { "<CMD>STSSelectChildNode<CR>", "Select child node" },
				["gh"] = { "<CMD>STSSwapOrHold<CR>", "Hold or swap with held node" },
			}
		end,
		config = true,
	},
	-- Syntax-aware comments
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "VeryLazy",
	},
	-- Yuck support
	{
		"elkowar/yuck.vim",
		ft = "yuck",
	},
}
