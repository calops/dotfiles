-- Neovide configuration
if vim.g.neovide then
    vim.g.neovide_floating_blur_amount_x = 1.5
    vim.g.neovide_floating_blur_amount_y = 1.5
    vim.g.neovide_scroll_animation_length = 0.13
    vim.g.neovide_window_floating_opacity = 1
    vim.o.guifont = 'FiraCode NF:h10'
end

-- Install plugin manager
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
end

---------- Core settings
vim.g.mapleader = ','
vim.o.inccommand = 'nosplit'
vim.o.number = true
vim.o.mouse = 'a'
vim.o.shortmess = 'c'
vim.o.concealcursor = ''
vim.o.textwidth = 120
vim.o.listchars = 'tab:→ ,nbsp:␣,trail:~,precedes:«,extends:»'
vim.o.list = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.laststatus = 3

vim.o.termguicolors = true
vim.o.background = 'dark'
vim.o.colorcolumn = 120 -- FIXME: not working somehow
vim.o.cursorline = true

vim.o.smarttab = true
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.autoindent = true
vim.g.catppuccin_flavour = "mocha"
vim.o.winblend = 0

---------- Plugins
local packer = require('packer')
packer.init {
    snapshot_path = fn.stdpath('config') .. '/snapshots',
}
packer.startup(function(use)
    -- Plugin manager
    use 'wbthomason/packer.nvim'

    ---------- IDE
    -- Installation commands for lspconfig
    use {
        'williamboman/mason.nvim',
        config = function() require('mason').setup()  end
    }
    use 'williamboman/mason-lspconfig.nvim'

    -- Language servers
    use 'neovim/nvim-lspconfig'

    -- Highlight symbols
    use 'RRethy/vim-illuminate'

    -- Symbols in autocompletion popups
    use 'onsails/lspkind.nvim'

    -- Autocompletion engine
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-git',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            local cmp = require 'cmp'

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                formatting = {
                    format = require('lspkind').cmp_format(),
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })

            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources(
                    {{ name = 'cmp_git' }},
                    {{ name = 'buffer' }}
                )
            })

            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end,
    }

    -- Better inline diagnostics
    use {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = function() require('lsp_lines').setup() end,
    }

    -- Snippet engine
    use 'L3MON4D3/LuaSnip'

    -- LSP code action hints
    use {
        'kosayoda/nvim-lightbulb',
        config = function()
            require('nvim-lightbulb').setup {
                autocmd = { enabled = true },
                sign = { enabled = false },
                virtual_text = { enabled = true, text = "" },
            }
        end,
    }

    -- LSP Diagnostics
    use {
        'folke/trouble.nvim',
        config = function() require('trouble').setup {} end,
    }

    use 'weilbith/nvim-code-action-menu'

    -- Incremental rename command
    use {
        'smjonas/inc-rename.nvim',
        config = function() require('inc_rename').setup() end,
    }

    -- Vim verbs to manipulate comments
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end,
    }

    -- Automatically adjust indent size
    use {
        'nmac427/guess-indent.nvim',
        config = function() require('guess-indent').setup {} end,
    }

    ---------- Git
    -- Git utility commands
    use 'tpope/vim-fugitive'

    -- Git chunks in gutter
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                signs = {
                    add = { text = '┃' },
                    change = { text = '┃' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '┃' },
                },
            }
        end,
    }

    ---------- File browsing
    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-media-files.nvim',
            'nvim-telescope/telescope-symbols.nvim',
            'nvim-telescope/telescope-vimspector.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', run = { 'make' } },
        },
        config = function()
            require('telescope').setup({
                defaults = {
                    layout_strategy = "flex",
                    layout_config = {
                        flex = {
                            flip_columns = 200,
                        },
                    },
                    winblend = 10,
                },
            })
            require('telescope').load_extension('fzf')
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("notify")
            require("telescope").load_extension("media_files")
        end,
    }

    -- File browser
    use {
        'nvim-neo-tree/neo-tree.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        config = function()
            require("neo-tree").setup {
                popup_border_style = "rounded",
            }
        end
    }

    ---------- Syntax
    -- Language-aware syntax highlighting and parsing utilities
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
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
                        init_selection = '<CR>',
                        scope_incremental = '<CR>',
                        node_incremental = '<TAB>',
                        node_decremental = '<S-TAB>',
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
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>p"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>P"] = "@parameter.inner",
                        },
                    },
                    lsp_interop = {
                        enable = true,
                        border = 'none',
                        peek_definition_code = {
                            ["<leader>df"] = "@function.outer",
                            ["<leader>dF"] = "@class.outer",
                        },
                    },
                },
                context_commentstring = { enable = true },
            }
        end,
    }

    -- Show current context on top
    use {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            require('treesitter-context').setup {
                enable = true,
                max_lines = 5,
                trim_scope = 'outer',
                zindex = 20,
                mode = 'cursor',
            }
        end,
    }

    -- Contextual code objects for vim verbs
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    -- Context-aware auto-comment
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    -- Syntax tree manipulation (TODO: bindings)
    use "ziontee113/syntax-tree-surfer"

    -- Indentation guides
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup {
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
                }
            }
        end,
    }

    ---------- UI
    -- Developer-specific icons, dependency for multiple modules
    use 'kyazdani42/nvim-web-devicons'

    -- Status line
    use {
        'feline-nvim/feline.nvim',
        after = 'catppuccin',
        config = function()
            local ctp_feline = require('catppuccin.groups.integrations.feline')
            ctp_feline.setup{}
            require('feline').setup {
                components = ctp_feline.get(),
            }
        end
    }

    -- Tab line
    use {
        'rafcamlet/tabline-framework.nvim',
        after = 'catppuccin',
        config = function()
            local colors = require("catppuccin.palettes").get_palette()
            local highlights = require('tabline_framework.highlights')
            local col_base = highlights.get_hl('TabLineFill')
            local col_active = highlights.get_hl('TabLineSel')
            local col_inactive = highlights.get_hl('TabLine')
            local sep_left = ' '
            local sep_right = ''

            require('tabline_framework').setup {
                render = function(f)
                    f.add { ' 裡 ', fg = colors.teal, bg = col_base.bg }

                    f.make_tabs(function(info)
                        local sep_fg
                        if info.current then
                            sep_fg = col_active.bg
                        else
                            sep_fg = col_inactive.bg
                        end
                        f.set_bg(sep_fg)

                        f.add { sep_left, fg = sep_fg, bg = col_base.bg }
                        f.add(info.index .. ' ')

                        if info.filename then
                            f.add(info.modified and '+')
                            f.add(info.filename)
                        else
                            f.add(info.modified and '[+]' or '[-]')
                        end

                        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(info.tab)) do
                            local buffer = vim.api.nvim_win_get_buf(win)
                            local buffer_name = vim.api.nvim_buf_get_name(buffer) or ''
                            local filename = buffer_name:match('^.+/(.+)$')
                            local icon = f.icon(filename)
                            local icon_color = f.icon_color(filename)

                            if icon ~= nil then
                                if info.current and icon_color ~= nil then
                                    f.set_fg(icon_color)
                                end
                                f.add(' ' .. icon)
                            end
                        end

                        f.add(' ')

                        f.add { sep_right, fg = sep_fg, bg = col_base.bg }
                    end)
                end,
            }
        end
    }

    -- Window line
    use {
        'b0o/incline.nvim',
        after = { 'tabline-framework.nvim', 'catppuccin' },
        config = function()
            local highlights = require('tabline_framework.highlights')
            local utils = require('catppuccin.utils.colors')
            local col_inactive = highlights.get_hl('InclineNormalNC')
            local col_active = highlights.get_hl('InclineNormal')
            local col_base = highlights.get_hl('Normal')
            local diag_colors = {
                highlights.get_hl('DiagnosticVirtualTextError'),
                highlights.get_hl('DiagnosticVirtualTextWarn'),
                highlights.get_hl('DiagnosticVirtualTextInfo'),
                highlights.get_hl('DiagnosticVirtualTextHint'),
            }

            require('incline').setup {
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':.')
                    local extension = filename:match("^.+%.(.+)$")
                    local icon, icon_fg_color = require('nvim-web-devicons').get_icon_colors(filename, extension)

                    local icon_color = {
                        fg = icon_fg_color,
                        bg = utils.darken(icon_fg_color, 0.3),
                    }

                    local color = col_inactive
                    if props.focused then
                        color = col_active
                    end

                    local result =  {
                        { '', guifg = icon_color.bg, guibg = col_base.bg },
                        { icon .. ' ', guifg = icon_color.fg, guibg = icon_color.bg },
                        { '', guifg = color.bg, guibg = icon_color.bg },
                        { filename },
                    }

                    local lsp_diagnostics = vim.diagnostic.get(props.buf)
                    local diag_counts = { 0, 0, 0, 0 }

                    for _, diag in ipairs(lsp_diagnostics) do
                        diag_counts[diag.severity] = diag_counts[diag.severity] + 1
                    end

                    local prev_color = color
                    for i=1,4 do
                        if diag_counts[i]> 0 then
                            table.insert(result, { '', guifg = prev_color.bg, guibg = diag_colors[i].bg })
                            table.insert(result, { ' ' .. diag_counts[i], guifg = diag_colors[i].fg, guibg = diag_colors[i].bg })
                            prev_color = diag_colors[i]
                        end
                    end

                    table.insert(result, { '', guifg = prev_color.bg, guibg = col_base.bg })

                    return result
                end,
                window = {
                    padding = 0,
                    placement = { horizontal = 'right', vertical = 'top' },
                    margin = {
                        horizontal = { left = 1, right = 1 },
                        vertical = { bottom = 1, top = 0 },
                    },
                },
            }
        end,
    }

    -- Session management
    use {
        'rmagatti/auto-session',
        config = function() require('auto-session').setup {
            cwd_change_handling = false,
        } end,
    }

    -- Modern notification popups
    use {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup {}
            vim.notify = require('notify')
        end,
    }

    ---------- Colors
    -- Colorscheme
    use {
        'catppuccin/nvim',
        as = 'catppuccin',
        config = function()
            require('catppuccin').setup {
                integrations = {
                    indent_blankline = {
                        enabled = true,
                        colored_indent_levels = true,
                    },
                    telescope = true,
                    native_lsp = {
                        enabled = true,
                        underlines = {
                            errors = { "undercurl" },
                            hints = { "undercurl" },
                            warnings = { "undercurl" },
                            information = { "undercurl" },
                        },
                    },
                    neotree = {
                        enabled = false,
                        show_root = true,
                        transparent_panel = false,
                    },
                },
                compile = {
                    enabled = true,
                },
            }
        end,
        run = ":CatppuccinCompile",
    }

    -- Firefox
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }

    -- Better search highlights
    use 'kevinhwang91/nvim-hlslens'

    ---------- Vim MISC
    -- Cheat sheet
    use {
        'folke/which-key.nvim',
        config = function() require('which-key').setup {} end,
    }

    -- Dependency for a few modules, including illuminate
    use {
        'antoinemadec/FixCursorHold.nvim',
        config = function()
            vim.g.cursorhold_updatetime = 200
        end,
    }

    -- Surround text objects
    use {
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup {}
        end
    }

    -- Startup time profiler
    use 'dstein64/vim-startuptime'

    if packer_bootstrap then
        require('packer').sync()
    end
end)

local mason = require('mason-lspconfig')
mason.setup {
    automatic_installation = true,
}

local on_attach = function(client)
    require('illuminate').on_attach(client)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')

lspconfig.util.default_config = vim.tbl_extend(
    "force",
    lspconfig.util.default_config,
    {
        on_attach = on_attach,
        capabilities = capabilities,
    }
)

for _, server in ipairs(mason.get_installed_servers()) do
    lspconfig[server].setup{}
end

require('lspconfig').sumneko_lua.setup {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { 'vim' }
            }
        }
    },
}

---------- Keybindings
local telescope_builtins = require('telescope.builtin')

local function nmap(binding, command, description, opts)
    opts = opts or {}

    vim.keymap.set('n', binding, command, {
        desc = description,
        silent = opts.silent or true,
        expr = opts.expr or false,
        noremap = opts.noremap or true,
    })
end

-- Code exploration
nmap('gD', vim.lsp.buf.declaration, 'Go to declaration')
nmap('gd', telescope_builtins.lsp_definitions, "Go to definition")
nmap('K', vim.lsp.buf.hover, "Show documentation")
nmap('H', function() vim.diagnostic.open_float({ border = "rounded" }) end, "Show diagnostics")
nmap('gi', vim.lsp.buf.implementation, "Go to implementation")
nmap('<C-k>', vim.lsp.buf.signature_help, "Interactive signature help")
nmap('gr', telescope_builtins.lsp_references, "List references")
nmap('<space>f', vim.lsp.buf.format, "Format code")
nmap("<leader>rn", function() return ":IncRename " .. vim.fn.expand("<cword>") end, "Interactive rename", { expr = true, silent = false })
nmap('<leader>a', ':CodeActionMenu<CR>', "Interactive list of code actions")

-- Fuzzy finder (telescope)
nmap('<C-p>', telescope_builtins.find_files, "Find files")
nmap('<leader><Space>', telescope_builtins.grep_string, "Grep string under cursor")
nmap('<leader>s', telescope_builtins.live_grep, "Live grep")
nmap('<leader>b', telescope_builtins.buffers, "Find buffer")
nmap('<leader>h', telescope_builtins.help_tags, "List help tags")
nmap('<leader>e', telescope_builtins.symbols, "Select symbol")

-- File browser
nmap('<leader>nn', ':Neotree toggle reveal_force_cwd<cr>', "Toggle file browser")
nmap('<leader>ng', ':Neotree float git_status<cr>', "Show git status")

-- Tabs
local function new_tab()
    vim.cmd [[
        let view = winsaveview()
        tabedit %
        call winrestview(view)
    ]]
end

nmap('<C-t>', new_tab, 'Open current buffer in new tab')
nmap('<C-Tab>', ':tabnext<CR>', 'View next tab')
nmap('<C-S-Tab>', ':tabprevious<CR>', 'View previous tab')

-- Syntax tree manipulation
require('syntax-tree-surfer')
local function dot_repeatable(op)
    return function()
        vim.opt.opfunc = op
        return "g@l"
    end
end

vim.keymap.set("n", "vU", dot_repeatable("v:lua.STSSwapUpNormal_Dot"), { silent = true, expr = true })
vim.keymap.set("n", "vD", dot_repeatable("v:lua.STSSwapDownNormal_Dot"), { silent = true, expr = true })
vim.keymap.set("n", "vu", dot_repeatable("v:lua.STSSwapCurrentNodePrevNormal_Dot"), { silent = true, expr = true })
vim.keymap.set("n", "vd", dot_repeatable("v:lua.STSSwapCurrentNodeNextNormal_Dot"), { silent = true, expr = true })

-- Search bindings
nmap('n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], 'Move to next match')
nmap('N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], 'Move to previous match')
nmap('*', [[*<Cmd>lua require('hlslens').start()<CR>]], 'Forward search symbol under cursor')
nmap('g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], 'Forward search symbol under cursor')
nmap('#', [[#<Cmd>lua require('hlslens').start()<CR>]], 'Backward search symbol under cursor')
nmap('g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], 'Backward search symbol under cursor')
nmap('<leader><leader>', ':noh<CR>', "Hide search highlights")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

-- Sort diagnostics by severity
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

nmap('<leader>m', toggle_virtual_lines, 'Toggle full inline diagnostics')

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

    colorscheme catppuccin
]])

-- Custom highlights (need to set them up after everything else)
local colors = require("catppuccin.palettes").get_palette()
require('catppuccin.lib.highlighter').syntax({
    NormalFloat = {},

    TreesitterContext = { bg = colors.base, style = { 'italic' } },
    TreesitterContextLineNumber = { fg = colors.lavender, style =  { 'italic' } },

    illuminatedWord = { bg = colors.surface1, style = { 'underdotted', 'bold' } },
    LspReferenceText = { bg = colors.surface1, style = { 'underdotted', 'bold' } },
    LspReferenceWrite = { bg = colors.surface1, style = { 'underdotted', 'bold' } },
    LspReferenceRead = { bg = colors.surface1, style = { 'underdotted', 'bold' } },

    InclineNormalNC = { bg = colors.surface1, fg = colors.base },
    InclineNormal = { bg = colors.overlay1, fg = colors.base, style = { 'bold' } },

    DiagnosticUnderlineError = { style =  { 'undercurl' } },
    DiagnosticUnderlineWarn = { style =  { 'undercurl' } },
    DiagnosticUnderlineInfo = { style =  { 'undercurl' } },
    DiagnosticUnderlineHint = { style =  { 'undercurl' } },

    TelescopeBorder = { fg = colors.peach },
})
