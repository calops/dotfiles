return {
    -- Comment commands
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("Comment").setup()
        end,
    },
    -- Automatically adjust indentation settings depending on the file
    {
        "nmac427/guess-indent.nvim",
        event = "InsertEnter",
        config = function()
            require("guess-indent").setup({})
        end,
    },
    -- Structural replace
    {
        "cshuaimin/ssr.nvim",
        init = function()
            vim.keymap.set({ "n", "x" }, "<leader>cR", function()
                require("ssr").open()
            end, { desc = "Structural replace" })
        end,
    },
    -- Surround text objects
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    -- Word families substitutions
    {
        "tpope/vim-abolish",
        event = "VeryLazy",
    }
}
