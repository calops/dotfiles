return {
    -- Diff viewer and merge tool
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        config = function()
            require("diffview").setup({
                enhanced_diff_hl = true,
                use_icons = true,
                view = {
                    default = { layout = "diff2_horizontal" },
                    merge_tool = {
                        layout = "diff4_mixed",
                        disable_diagnostics = true,
                    },
                },
            })
        end,
    },
    -- Git utilities, gutter signs
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        config = function ()
            require('gitsigns').setup {
                numhl = false,
                sign_priority = 1,
                preview_config = {
                    border = 'rounded',
                },
            }
        end,
    },
    -- Git commands
    {
        "tpope/vim-fugitive",
        cmd = "Git",
    },
    -- Github integration
    {
        "pwntester/octo.nvim",
        lazy = true,
        cmd = "Octo",
        config = function()
            require("octo").setup()
        end,
    },
}
