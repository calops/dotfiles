return {
    -- Diff viewer and merge tool
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "DiffViewOpen", "DiffViewFileHistory" },
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
        "tanvirtin/vgit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
        config = function()
            require("vgit").setup({
                settings = {
                    live_gutter = { enabled = true },
                    live_blame = { enabled = false },
                },
            })
        end,
    },
    -- Git commands
    {
        "tpope/vim-fugitive",
        cmd = "Git",
    }
}
