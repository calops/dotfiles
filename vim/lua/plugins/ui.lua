local nmap = require("core.utils").nmap
return {
    -- Colorful modes
    {
        "mvllow/modes.nvim",
        event = "VeryLazy",
        config = function()
            require("modes").setup()
        end,
    },
    -- CMD line replacement and other UI niceties
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        lazy = false,
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
                    messages = { backend = "popup" },
                },
                popupmenu = { enabled = true, backend = "nui" },
                routes = {
                    {
                        view = "notify",
                        filter = { event = "msg_show", find = '"*"*lines --*%--' },
                        opts = { skip = true },
                    },
                },
            })
            nmap("<leader><leader>", ":noh<CR>", "Hide search highlights")
        end,
    },
    -- IDE panels
    {
        "ldelossa/nvim-ide",
        cmd = "Workspace",
        init = function()
            nmap("<leader>wl", ":Workspace LeftPanelToggle<CR>", "Toggle git panels")
            nmap("<leader>wr", ":Workspace RightPanelToggle<CR>", "Toggle IDE panels")
        end,
        config = function()
            require("ide").setup({
                workspaces = {
                    auto_open = "none",
                },
                panel_sizes = {
                    left = 60,
                    right = 60,
                    bottom = 15,
                },
            })
        end,
    },
    -- Better select dialog
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        config = function()
            require("dressing").setup({
                input = { enabled = false },
                select = { enabled = true },
            })
        end,
    },
    -- Context-aware indentation lines
    {
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
    },
    -- Notification handler
    {
        "rcarriga/nvim-notify",
        lazy = false,
        config = function()
            require("notify").setup({
                top_down = true,
                max_width = 100,
            })
        end,
    },
    -- Keymaps cheat sheet and tooltips
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup({
                window = {
                    border = "rounded",
                    position = "bottom", -- bottom, top
                    winblend = 20,
                },
            })
        end,
    }
}
