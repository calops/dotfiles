local nmap = require("core.utils").nmap
return {
    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-media-files.nvim",
            "nvim-telescope/telescope-symbols.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = function()
                    io.popen("make")
                end,
            },
            {
                "prochri/telescope-all-recent.nvim",
                dependencies = { "kkharji/sqlite.lua" }
            },
        },
        cmd = "Telescope",
        lazy = true,
        init = function()
            nmap {
                ["<C-p>"] = { function() require("telescope.builtin").find_files() end, "Find files" },
                ["<leader>"] = {
                    ["<Space>"] = { function() require("telescope.builtin").grep_string() end, "Grep string under cursor" },
                    s = { function() require("telescope.builtin").live_grep() end, "Live grep" },
                    b = { function() require("telescope.builtin").buffers() end, "Find buffer" },
                    e = { function() require("telescope.builtin").symbols() end, "Select symbol" },
                    R = { function() require("telescope.builtin").resume() end, "Resume selection" },
                }
            }
        end,
        config = function()
            require("notify")
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    layout_strategy = "flex",
                    layout_config = {
                        flex = { flip_columns = 200 },
                    },
                    mappings = { i = { ["<esc>"] = actions.close } },
                },
            })
            telescope.load_extension("fzf")
            telescope.load_extension("notify")
            telescope.load_extension("media_files")
            require("telescope-all-recent").setup({})
        end,
    },
    -- File tree browser
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        init = function()
            nmap {
                ["<leader>n"] = {
                    name = "file tree",
                    n = { ":Neotree toggle reveal_force_cwd<cr>", "Toggle file browser" },
                    g = { ":Neotree float git_status<cr>", "Show git status" },
                }
            }
        end,
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
        end,
    },
}
