return {
    {
        "rebelot/heirline.nvim",
        lazy = false,
        enabled = false,
        config = function()
            vim.o.signcolumn = "no"
            vim.o.foldcolumn = '0'

            require("heirline").setup {
                statuscolumn = {
                    {
                        provider = function ()
                            return vim.v.lnum
                        end,
                    },
                    {
                        provider = "%l",
                    },
                },
            }
        end
    }
}
