local nmap = require("core.utils").nmap
return {
    -- Show LSP code action hint
    {
        "kosayoda/nvim-lightbulb",
        event = "LspAttach",
        config = function()
            require("nvim-lightbulb").setup({
                autocmd = { enabled = true },
                sign = { enabled = false },
                virtual_text = { enabled = true, text = "" },
            })
        end,
    },
    -- Show rich inline diagnostics
    {
        url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        lazy = true,
        init = function()
            local function toggle_virtual_lines()
                local is_enabled = vim.diagnostic.config().virtual_lines

                vim.diagnostic.config({
                    virtual_lines = not is_enabled,
                    virtual_text = is_enabled,
                })
            end

            nmap {
                ["<leader>m"] = { function() require("lsp_lines") toggle_virtual_lines() end,
                    "Toggle full inline diagnostics" }
            }
        end,
        config = function()
            require("lsp_lines").setup()

            vim.diagnostic.config({
                signs = true,
                severity_sort = true,
                virtual_lines = false,
            })
        end,
    },
    -- Code definition and references peeking
    {
        "dnlhc/glance.nvim",
        cmd = "Glance",
        init = function()
            nmap {
                g = {
                    d = { "<CMD>Glance definitions<CR>", "Peek definition(s)" },
                    r = { "<CMD>Glance references<CR>", "Peek references" },
                    D = { "<CMD>Glance type_definitions<CR>", "Peek declarations" },
                    i = { "<CMD>Glance implementations<CR>", "Peek implementations" },
                }
            }
        end,
        config = function()
            require("glance").setup({
                height = 25,
                border = {
                    enable = true,
                    top_char = '▔',
                    bottom_char = '▁',
                },
                theme = { enable = true, mode = "auto" },
            })
        end,
    },
    -- Highlight symbols under cursor, LSP and treesitter-aware
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy"
    },
    -- Diagnostics window
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        init = function()
            nmap { ["<leader>t"] = { function() require("trouble").toggle() end, "Open diagnostics window" } }
        end,
        config = function()
            require("trouble").setup({})
        end,
    },
    -- Diagnostic markers on the right of the file
    {
        'doums/dmap.nvim',
        event = 'LspAttach',
        enabled = true,
        config = function()
            require('dmap').setup()
        end
    },
}
