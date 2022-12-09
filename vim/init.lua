-- Neovide configuration
vim.g.neovide_floating_blur_amount_x = 1.5
vim.g.neovide_floating_blur_amount_y = 1.5
vim.g.neovide_scroll_animation_length = 0.13
vim.g.neovide_background_color = "#000000aa"
vim.o.guifont = "Iosevka Nerd Font:h10"

-- Install plugin manager
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap =
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

---------- Core settings
vim.g.mapleader = ","
vim.o.inccommand = "nosplit"
vim.o.number = true
vim.o.mouse = "a"
vim.o.shortmess = "c"
vim.o.concealcursor = ""
vim.o.textwidth = 120
vim.o.listchars = "tab:→ ,nbsp:␣,trail:~,precedes:«,extends:»"
vim.o.list = true
vim.o.wrap = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.laststatus = 3
vim.g.rustfmt_autosave = false
vim.o.fillchars = 'diff:╱'
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.colorcolumn = 120 -- FIXME: not working somehow
vim.o.cursorline = true

vim.o.smarttab = true
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.autoindent = true
vim.g.catppuccin_flavour = "mocha"
vim.o.winblend = 10
vim.o.pumblend = 10
vim.o.cmdheight = 1

local function keymap(mode, binding, command, description, opts)
	local defaults = {
		silent = true,
		expr = false,
		noremap = true,
		desc = description,
	}
	local options = vim.tbl_extend("force", defaults, opts or {})

	vim.keymap.set(mode, binding, command, options)
end

function Nmap(binding, command, description, opts)
	keymap("n", binding, command, description, opts)
end

function Xmap(binding, command, description, opts)
	keymap("x", binding, command, description, opts)
end

---------- Plugins
local packer = require("packer")
packer.init({
	snapshot_path = fn.stdpath("config") .. "/snapshots",
})
packer.startup(function(use)
	-- Plugin manager
	use("wbthomason/packer.nvim")

	---------- IDE
	-- Installation commands for lspconfig
	use({
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	})
	use("williamboman/mason-lspconfig.nvim")

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local nls = require("null-ls")
			nls.setup({
				sources = {
					nls.builtins.formatting.stylua,
					nls.builtins.diagnostics.buf,
				},
			})
		end,
	})

	-- Language servers
	use {
		"neovim/nvim-lspconfig",
		config = function ()
			
		end,
	}

	use("rust-lang/rust.vim")

	-- Highlight symbols
	use("RRethy/vim-illuminate")

	-- Rust tools
	use("simrat39/rust-tools.nvim")

	-- Symbols in autocompletion popups
	use("onsails/lspkind.nvim")

	-- Autocompletion engine
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-git",
			"saadparwaiz1/cmp_luasnip",
			"davidsierradz/cmp-conventionalcommits",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, { { name = "buffer" } }),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					format = require("lspkind").cmp_format(),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})

			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources(
					{ { name = "conventionalcommits" } },
					{ { name = "cmp_git" } },
					{ { name = "buffer" } }
				),
			})

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
			require("cmp_git").setup()
		end,
	})

	-- Better inline diagnostics
	use({
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()

			vim.diagnostic.config({
				signs = true,
				severity_sort = true,
				virtual_lines = false,
			})

			local function toggle_virtual_lines()
				local is_enabled = vim.diagnostic.config().virtual_lines

				vim.diagnostic.config({
					virtual_lines = not is_enabled,
					virtual_text = is_enabled,
				})
			end

			Nmap("<leader>m", toggle_virtual_lines, "Toggle full inline diagnostics")
		end,
	})

	-- Snippet engine
	use("L3MON4D3/LuaSnip")

	-- LSP code action hints
	use({
		"kosayoda/nvim-lightbulb",
		config = function()
			require("nvim-lightbulb").setup({
				autocmd = { enabled = true },
				sign = { enabled = false },
				virtual_text = { enabled = true, text = "" },
			})
		end,
	})

	-- LSP Diagnostics
	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup {}
		end,
	})

	-- Vim verbs to manipulate comments
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- Automatically adjust indent size
	use({
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({})
		end,
	})

	---------- Git
	-- Git utility commands
	use("tpope/vim-fugitive")

	-- Git chunks in gutter
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "┃" },
				},
			})
		end,
	})

	---------- File browsing
	-- Fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = { "make" } },
		},
		config = function()
			local telescope = require("telescope")
			local telescope_builtins = require("telescope.builtin")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					layout_strategy = "flex",
					layout_config = {
						flex = {
							flip_columns = 200,
						},
					},
					winblend = 10,
					mappings = { i = { ["<esc>"] = actions.close } },
				},
			})
			telescope.load_extension("fzf")
			telescope.load_extension("notify")
			telescope.load_extension("media_files")
			local function live_grep()
				vim.ui.input({ prompt = "Grep string: " }, function(input)
					if input == nil or input == "" then
						telescope_builtins.live_grep()
					else
						telescope_builtins.grep_string({ search = input })
					end
				end)
			end

			Nmap("<C-p>", telescope_builtins.find_files, "Find files")
			Nmap("<leader><Space>", telescope_builtins.grep_string, "Grep string under cursor")
			Nmap("<leader>s", live_grep, "Live grep")
			Nmap("<leader>b", telescope_builtins.buffers, "Find buffer")
			Nmap("<leader>h", telescope_builtins.help_tags, "List help tags")
			Nmap("<leader>e", telescope_builtins.symbols, "Select symbol")
			Nmap("<leader>t", require('trouble').toggle, "Open diagnostics window (trouble)")
		end,
	})

	-- Better select and input menus
	use({
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = {
					enabled = false,
				},
				select = {
					enabled = true,
				},
			})
		end,
	})

	-- File browser
	use({
		"nvim-neo-tree/neo-tree.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				popup_border_style = "rounded",
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = true,
					},
				},
			})
			Nmap("<leader>nn", ":Neotree toggle reveal_force_cwd<cr>", "Toggle file browser")
			Nmap("<leader>ng", ":Neotree float git_status<cr>", "Show git status")
		end,
	})

	---------- Syntax
	-- Language-aware syntax highlighting and parsing utilities
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				indent = {
					enable = true,
				},
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
							["x"] = "@swappable",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>p"] = "@swappable",
						},
						swap_previous = {
							["<leader>P"] = "@swappable",
						},
					},
					lsp_interop = {
						enable = true,
						border = "none",
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
				},
				context_commentstring = { enable = true },
				playground = {
					enable = true,
				},
			})
			-- require"nvim-treesitter.highlight".set_custom_captures {
			--     ["interface"] = "TSInterface",
			--     ["implementation"] = "TSInterface",
			-- }
		end,
	})

	use("nvim-treesitter/playground")

	-- Show current context on top
	use({
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true,
				max_lines = 5,
				trim_scope = "outer",
				zindex = 40,
				mode = "cursor",
			})
		end,
	})

	-- Contextual code objects for vim verbs
	use("nvim-treesitter/nvim-treesitter-textobjects")

	-- Context-aware auto-comment
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Syntax tree manipulation (TODO: bindings)
	use {
		"ziontee113/syntax-tree-surfer",
		config = function()
			require("syntax-tree-surfer")

			local function dot_repeatable(op)
				return function()
					vim.opt.opfunc = op
					return "g@l"
				end
			end

			Nmap("vu", dot_repeatable("v:lua.STSSwapUpNormal_Dot"), "Swap object upwards", { expr = true })
			Nmap("vd", dot_repeatable("v:lua.STSSwapDownNormal_Dot"), "Swap object downwards", { expr = true })
			Nmap("vU", dot_repeatable("v:lua.STSSwapCurrentNodePrevNormal_Dot"), "Swap node forwards", { expr = true })
			Nmap("vD", dot_repeatable("v:lua.STSSwapCurrentNodeNextNormal_Dot"), "Swap node backwards", { expr = true })
		end
	}

	-- Indentation guides
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				show_current_context = true,
				show_current_context_start = false,
				use_treesitter = true,
				max_indent_increase = 1,
				show_trailing_blankline_indent = false,
				integrations = {
					neotree = {
						enabled = true,
						show_root = false,
						transparent_panel = false,
					},
				},
			})
		end,
	})

	---------- UI
	-- Developer-specific icons, dependency for multiple modules
	use("kyazdani42/nvim-web-devicons")

	-- Status line
	use({
		"feline-nvim/feline.nvim",
		after = "catppuccin",
		config = function()
			local ctp_feline = require("catppuccin.groups.integrations.feline")
			ctp_feline.setup({})
			require("feline").setup({
				components = ctp_feline.get(),
			})
		end,
	})
	-- use {
	-- 	"rebelot/heirline.nvim",
	-- 	config = function()
	-- 		local conditions = require("heirline.conditions")
	-- 		local utils = require("heirline.utils")
	--
	-- 		local statusline = {}
	-- 		local winbar = {}
	-- 		local tabline = {}
	-- 		require('heirline').setup { statusline, winbar, tabline }
	-- 	end
	-- }

	-- Tab line
	use({
		"rafcamlet/tabline-framework.nvim",
		after = "catppuccin",
		config = function()
			local colors = require("catppuccin.palettes").get_palette()
			local highlights = require("tabline_framework.highlights")
			local col_base = highlights.get_hl("TabLineFill")
			local col_active = highlights.get_hl("TabLineSel")
			local col_inactive = highlights.get_hl("TabLine")
			local sep_left = " "
			local sep_right = ""

			require("tabline_framework").setup({
				render = function(f)
					f.add({ " 裡 ", fg = colors.teal, bg = col_base.bg })

					f.make_tabs(function(info)
						local sep_fg
						if info.current then
							sep_fg = col_active.bg
						else
							sep_fg = col_inactive.bg
						end
						f.set_bg(sep_fg)

						f.add({ sep_left, fg = sep_fg, bg = col_base.bg })
						f.add(info.index .. " ")

						if info.filename then
							f.add(info.modified and "+")
							f.add(info.filename)
						else
							f.add(info.modified and "[+]" or "[-]")
						end

						for _, win in ipairs(vim.api.nvim_tabpage_list_wins(info.tab)) do
							local buffer = vim.api.nvim_win_get_buf(win)
							local buffer_name = vim.api.nvim_buf_get_name(buffer) or ""
							local filename = buffer_name:match("^.+/(.+)$")
							local icon = f.icon(filename)
							local icon_color = f.icon_color(filename)

							if icon ~= nil then
								if info.current and icon_color ~= nil then
									f.set_fg(icon_color)
								end
								f.add(" " .. icon)
							end
						end

						f.add(" ")

						f.add({ sep_right, fg = sep_fg, bg = col_base.bg })
					end)
				end,
			})
		end,
	})

	-- Window line
	use({
		"b0o/incline.nvim",
		after = { "tabline-framework.nvim", "catppuccin" },
		config = function()
			local highlights = require("tabline_framework.highlights")
			local utils = require("catppuccin.utils.colors")
			local col_inactive = highlights.get_hl("InclineNormalNC")
			local col_active = highlights.get_hl("InclineNormal")
			local col_base = highlights.get_hl("Normal")
			local diag_colors = {
				highlights.get_hl("DiagnosticVirtualTextError"),
				highlights.get_hl("DiagnosticVirtualTextWarn"),
				highlights.get_hl("DiagnosticVirtualTextInfo"),
				highlights.get_hl("DiagnosticVirtualTextHint"),
			}

			require("incline").setup({
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":.")
					local extension = filename:match("^.+%.(.+)$")
					local icon, icon_fg_color =
					require("nvim-web-devicons").get_icon_colors(filename, extension, { default = true })

					local icon_color = {
						fg = icon_fg_color,
						bg = utils.darken(icon_fg_color, 0.3),
					}

					local color = col_inactive
					if props.focused then
						color = col_active
					end

					local result = {
						{ "", guifg = icon_color.bg, guibg = col_base.bg },
						{ icon .. " ", guifg = icon_color.fg, guibg = icon_color.bg },
						{ "", guifg = color.bg, guibg = icon_color.bg },
						{ filename },
					}

					local lsp_diagnostics = vim.diagnostic.get(props.buf)
					local diag_counts = { 0, 0, 0, 0 }

					for _, diag in ipairs(lsp_diagnostics) do
						diag_counts[diag.severity] = diag_counts[diag.severity] + 1
					end

					local prev_color = color
					for i = 1, 4 do
						if diag_counts[i] > 0 then
							table.insert(result, { "", guifg = prev_color.bg, guibg = diag_colors[i].bg })
							table.insert(
								result,
								{ " " .. diag_counts[i], guifg = diag_colors[i].fg, guibg = diag_colors[i].bg }
							)
							prev_color = diag_colors[i]
						end
					end

					table.insert(result, { "", guifg = prev_color.bg, guibg = col_base.bg })

					return result
				end,
				window = {
					zindex = 100,
					padding = 0,
					placement = { horizontal = "right", vertical = "top" },
					margin = {
						horizontal = { left = 1, right = 1 },
						vertical = { bottom = 1, top = 0 },
					},
				},
			})
		end,
	})

	-- Session management
	use({
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				cwd_change_handling = false,
				bypass_session_save_file_types = { "neo-tree" },
				pre_save_cmds = {
					function()
						require("neo-tree.sources.manager").close_all()
					end,
				},
			})
		end,
	})

	-- Modern notification popups
	use({
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				top_down = true,
				max_width = 100,
			})
		end,
	})

	---------- Colors
	-- Colorscheme
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("catppuccin").setup({
				integrations = {
					telescope = true,
					neotree = {
						enabled = true,
						show_root = true,
						transparent_panel = false,
					},
					indent_blankline = {
						enabled = true,
						colored_indent_levels = true,
					},
				},
				compile = {
					enabled = true,
				},
			})
		end,
		run = require('catppuccin').compile,
	})

	-- Firefox
	use({
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
	})

	-- Better search highlights
	use {
		"kevinhwang91/nvim-hlslens",
		config = function()
			require('hlslens').setup()
			Nmap(
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				"Move to next match"
			)
			Nmap(
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				"Move to previous match"
			)
			Nmap("*", [[*<Cmd>lua require('hlslens').start()<CR>]], "Forward search symbol under cursor")
			Nmap("g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], "Forward search symbol under cursor")
			Nmap("#", [[#<Cmd>lua require('hlslens').start()<CR>]], "Backward search symbol under cursor")
			Nmap("g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], "Backward search symbol under cursor")
			Nmap("<leader><leader>", ":noh<CR>", "Hide search highlights")
		end
	}

	---------- Vim MISC
	-- Cheat sheet
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})

	-- Dependency for a few modules, including illuminate
	use({
		"antoinemadec/FixCursorHold.nvim",
		config = function()
			vim.g.cursorhold_updatetime = 200
		end,
	})

	-- Surround text objects
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	})

	-- Startup time profiler
	use("dstein64/vim-startuptime")

	-- Terminal manager
	use({
		"akinsho/toggleterm.nvim",
		tag = "v2.*",
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
		end,
	})

	-- Speed-up startup time
	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient")
		end,
	})

	-- Git utilities
	use({
		"tanvirtin/vgit.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("vgit").setup({
				settings = {
					live_gutter = {
						enabled = false,
					},
					live_blame = {
						enabled = false,
					},
				},
			})
		end,
	})

	-- Merge tool
	use({
		"sindrets/diffview.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("diffview").setup({
				enhanced_diff_hl = true,
				use_icons = true,
				view = {
					default = {
						layout = "diff2_horizontal",
					},
					merge_tool = {
						layout = "diff4_mixed",
						disable_diagnostics = true,
					},
				},
			})
		end,
	})

	-- Colorful cursorline
	use({
		"mvllow/modes.nvim",
		config = function()
			require("modes").setup()
		end,
	})

	use({
		"folke/noice.nvim",
		event = "VimEnter",
		requires = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = false,
					command_palette = true,
					long_message_to_split = true,
					lsp_doc_border = true,
				},
				views = {
					messages = {
						backend = "popup",
					},
				},
				popupmenu = {
					enabled = true,
					backend = "nui",
				},
				routes = {
					{
						view = "notify",
						filter = { event = "msg_show", find = "\"*\"*lines --*%--" },
						opts = { skip = true },
					},
				},
			})
		end
	})

	-- Clipboard forwarding
	use {
		'ojroques/nvim-osc52',
		config = function()
			local osc52 = require('osc52')

			Nmap('<leader>c', osc52.copy_operator, "Copy to clipboard", { expr = true })
			Nmap('<leader>cc', '<leader>c_', "Copy line to clipboard", { remap = true })
			Xmap('<leader>c', osc52.copy_visual, "Copy selection to clipboard")

			local function copy()
				if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
					osc52.copy_register('+')
				end
			end

			vim.api.nvim_create_autocmd('TextYankPost', { callback = copy })
		end
	}

	-- Better reference window
	use {
		"dnlhc/glance.nvim",
		config = function()
			local glance = require('glance')
			glance.setup {
				height = 25,
				border = {
					enable = true,
				},
				theme = {
					enable = true,
					mode = 'auto',
				},
			}
			Nmap('gd', '<CMD>Glance definitions<CR>', 'Peek definition(s)')
			Nmap('gr', '<CMD>Glance references<CR>', 'Peek references')
			Nmap('gD', '<CMD>Glance type_definitions<CR>', 'Peek declarations')
			Nmap('gi', '<CMD>Glance implementations<CR>', 'Peek implementations')
		end,
	}

	if packer_bootstrap then
		require("packer").sync()
	end
end)

local mason = require("mason-lspconfig")
mason.setup({
	automatic_installation = true,
})

local on_attach = function(client) end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require("lspconfig")

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
	on_attach = on_attach,
	capabilities = capabilities,
})

for _, server in ipairs(mason.get_installed_servers()) do
	if server ~= "rust_analyzer" then
		lspconfig[server].setup({})
	end
end

local custom_lsp_conf
if vim.fn.filereadable(".lsp.lua") == true then
	custom_lsp_conf = dofile(".lsp.lua")
else
	custom_lsp_conf = {}
end
local rust_lsp_conf = vim.tbl_extend("force", {
	rustfmt = {
		extraArgs = {
			"--config",
			"comment_width=120,condense_wildcard_suffixes=false,format_code_in_doc_comments=true,format_macro_bodies=true,hex_literal_case=Upper,imports_granularity=One,normalize_doc_attributes=true,wrap_comments=true",
		},
	},
	semanticHighlighting = {
		["punctuation.enable"] = true,
		["punctuation.separate.macro.bang"] = true,
	},
}, custom_lsp_conf)

require("rust-tools").setup({
	tools = {
		inlay_hints = {
			highlight = "InlayHints",
		},
	},
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			["rust-analyzer"] = rust_lsp_conf,
		},
	},
})

require("lspconfig").sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

---------- Keybindings
Nmap("K", vim.lsp.buf.hover, "Show documentation")
Nmap("H", function()
	vim.diagnostic.open_float({ border = "rounded" })
end, "Show diagnostics")
Nmap("<C-k>", vim.lsp.buf.signature_help, "Interactive signature help")
Nmap("<space>f", vim.lsp.buf.format, "Format code")
Nmap("<leader>rn", vim.lsp.buf.rename, "Interactive rename")
Nmap("<leader>rf", vim.lsp.buf.format, "Format code")
Nmap("<leader>a", vim.lsp.buf.code_action, "Interactive list of code actions")

-- Tabs
local function new_tab()
	vim.cmd([[
        let view = winsaveview()
        tabedit %
        call winrestview(view)
    ]])
end

Nmap("<C-t>", new_tab, "Open current buffer in new tab")
Nmap("<C-Tab>", ":tabnext<CR>", "View next tab")
Nmap("<C-S-Tab>", ":tabprevious<CR>", "View previous tab")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

-- Native vim commands
vim.cmd([[
    " Fixed size help panel
    augroup vimrc_help
        autocmd!
        autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | vert resize 80 | set winfixwidth | endif
    augroup END

    set colorcolumn=120 " see above, temporary fix

    sign define DiagnosticSignError text= texthl=DiagnosticSignError numhl=DiagnosticSignError linehl=
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn numhl=DiagnosticSignWarn linehl=
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo numhl=DiagnosticSignInfo linehl=
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint numhl=DiagnosticSignHint linehl=

    autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-f> <Cmd>exe v:count1 . "ToggleTerm"<CR>
    nnoremap <silent><c-f> <Cmd>exe v:count1 . "ToggleTerm"<CR>
    inoremap <silent><c-f> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

    colorscheme catppuccin
]])

-- Auto format on save, rust files only
require("core.autocmd").BufWritePost = {
	"*.rs",
	function()
		for _, client in ipairs(vim.lsp.get_active_clients()) do
			if client.attached_buffers[vim.api.nvim_get_current_buf()] then
				vim.lsp.buf.format()
				return
			else
				return
			end
		end
	end,
}

-- Custom highlights (need to set them up after everything else)
local colors = require("catppuccin.palettes").get_palette()
local utils = require("catppuccin.utils.colors")
require("catppuccin.lib.highlighter").syntax({
	NormalFloat = { bg = colors.base },
	TermFloatBorder = { fg = colors.red },

	TreesitterContext = { bg = colors.base, style = { "italic" }, blend = 0 },
	TreesitterContextLineNumber = { fg = colors.surface1, bg = colors.crust, style = { "italic" }, blend = 0 },

	IlluminatedWordText = { bg = colors.surface1, style = { "underdotted", "bold" } },
	IlluminatedWordWrite = { bg = colors.surface1, style = { "underdotted", "bold" } },
	IlluminatedWordRead = { bg = colors.surface1, style = { "underdotted", "bold" } },

	InclineNormalNC = { bg = colors.surface1, fg = colors.base, blend = 0 },
	InclineNormal = { bg = colors.overlay1, fg = colors.base, blend = 0 },

	DiagnosticUnderlineError = { sp = colors.red, style = { "undercurl" } },
	DiagnosticUnderlineWarn = { sp = colors.yellow, style = { "undercurl" } },
	DiagnosticUnderlineInfo = { sp = colors.sky, style = { "undercurl" } },
	DiagnosticUnderlineHint = { sp = colors.teal, style = { "undercurl" } },

	TelescopeBorder = { fg = colors.peach },

	ModesInsert = { bg = colors.green },
	ModesVisual = { bg = colors.mauve },

	["@namespace"] = { fg = colors.maroon },
	["@parameter"] = { fg = colors.pink, style = { "italic" } },
	["@variable"] = { fg = colors.pink },
	["@keyword"] = { fg = colors.mauve, style = { "bold" } },
	["@keyword.function"] = { link = "@keyword" },

	HLSearchLensNear = { fg = colors.sky, style = { "bold" } },
	HLSearchLens = { fg = colors.surface1 },

	CodewindowBorder = { fg = colors.surface1 },

	IndentBlanklineChar = { style = { "nocombine" } },
	IndentBlanklineSpaceChar = { style = { "nocombine" } },
	IndentBlanklineContextChar = { style = { "nocombine" } },
	IndentBlanklineContextSpaceChar = { style = { "nocombine" } },
	IndentBlanklineSpaceCharBlankline = { style = { "nocombine" } },

	InlayHints = { fg = colors.surface1 },
	Comment = { fg = utils.darken(colors.lavender, 0.6) }
})
