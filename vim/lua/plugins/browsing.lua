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
        },
        lazy = true,
        init = function()
            local function live_grep()
                vim.ui.input({ prompt = "Grep string: " }, function(input)
                    if input == nil or input == "" then
                        require("telescope.builtin").live_grep()
                    else
                        require("telescope.builtin").grep_string({ search = input })
                    end
                end)
            end

            nmap("<C-p>", function() require("telescope.builtin").find_files() end, "Find files")
            nmap("<leader><Space>", function() require("telescope.builtin").grep_string() end, "Grep string under cursor")
            nmap("<leader>s", live_grep, "Live grep")
            nmap("<leader>b", function() require("telescope.builtin").buffers() end, "Find buffer")
            nmap("<leader>h", function() require("telescope.builtin").help_tags() end, "List help tags")
            nmap("<leader>e", function() require("telescope.builtin").symbols() end, "Select symbol")
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
                    winblend = 10,
                    mappings = { i = { ["<esc>"] = actions.close } },
                },
            })
            telescope.load_extension("fzf")
            telescope.load_extension("notify")
            telescope.load_extension("media_files")
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
            nmap("<leader>nn", ":Neotree toggle reveal_force_cwd<cr>", "Toggle file browser")
            nmap("<leader>ng", ":Neotree float git_status<cr>", "Show git status")
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
    }
}
