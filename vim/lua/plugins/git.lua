local nmap = require('core.utils').nmap

return {
    -- Diff viewer and merge tool
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        opts = {
            enhanced_diff_hl = true,
            use_icons = true,
            view = {
                default = { layout = "diff2_horizontal" },
                merge_tool = {
                    layout = "diff4_mixed",
                    disable_diagnostics = true,
                },
            },
        },
    },
    -- Git utilities, gutter signs
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        config = function()
            local gitsigns = require('gitsigns')

            gitsigns.setup {
                numhl = false,
                sign_priority = 1,
                preview_config = {
                    border = 'rounded',
                },
            }

            nmap {
                ['<leader>g'] = {
                    name = 'git',
                    s = { gitsigns.stage_hunk, 'Stage hunk' },
                    u = { gitsigns.undo_stage_hunk, 'Undo "stage hunk"' },
                    r = { gitsigns.reset_hunk, 'Reset hunk' },
                    n = { gitsigns.next_hunk, 'Next hunk' },
                    N = { gitsigns.prev_hunk, 'Previous hunk' },
                    p = { gitsigns.preview_hunk_inline, 'Preview hunk' },
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
        config = true,
    },

    {
        dir = '~/github/gitroutine.nvim',
        name = 'gitroutine',
        enabled = true,
        event = "VeryLazy",
        config = function()
            require('gitroutine').setup { foo = "bar" }
        end
    }
}
