local nmap = require("core.utils").nmap

local function make_capabilities()
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }
    return capabilities
end

return {
    -- Show icons for LSP completions
    {
        "onsails/lspkind.nvim",
        event = "LspAttach",
    },
    -- Language servers and utilities orchestrator
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup {
                ui = {
                    border = "rounded",
                }
            }
        end,
    },
    -- General LSP setup
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local mason = require("mason-lspconfig")
            mason.setup({ automatic_installation = true })

            local lspconfig = require("lspconfig")

            lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
                capabilities = make_capabilities(),
            })

            for _, server in ipairs(mason.get_installed_servers()) do
                if server ~= "rust-analyzer" then
                    lspconfig[server].setup({})
                end
            end

            require("lspconfig").lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
        end,
    },
    -- LSP bridge for non-LSP utilities
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        config = function()
            local nls = require("null-ls")
            nls.setup({
                sources = {
                    nls.builtins.formatting.stylua,
                    nls.builtins.diagnostics.buf,
                    nls.builtins.formatting.npm_groovy_lint,
                },
            })
        end,
    },
    -- Rust-specific utilities and LSP configurations
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        lazy = true,
        enabled = true,
        config = function()
            -- require('neoconf')
            local rust_lsp_conf = {
                semanticHighlighting = {
                    ["punctuation.enable"] = true,
                    ["punctuation.separate.macro.bang"] = true,
                },
                diagnostics = {
                    enable = true,
                    disabled = { "unresolved-method", "unresolved-field" },
                    experimental = { enable = false },
                },
                assist = {
                    emitMustUse = true,
                },
            }

            require("rust-tools").setup({
                tools = {
                    inlay_hints = {
                        highlight = "InlayHints",
                    },
                },
                server = {
                    capabilities = make_capabilities(),
                    settings = { ["rust-analyzer"] = rust_lsp_conf },
                },
            })
            -- Auto format on save
            require("core.autocmd").BufWritePre = {
                "*.rs",
                function()
                    for _, client in ipairs(vim.lsp.get_active_clients()) do
                        if client.attached_buffers[vim.api.nvim_get_current_buf()] then
                            vim.lsp.buf.format()
                            return
                        else
                            return
                        end
                    end
                end,
            }
        end,
    },
    -- First-party LSP configurations
    {
        "neovim/nvim-lspconfig",
        config = function()
            require('neoconf')
            nmap {
                K = { vim.lsp.buf.hover, "Show documentation" },
                H = { function() vim.diagnostic.open_float({ border = "rounded" }) end, "Show diagnostics" },
                ["<C-k>"] = { vim.lsp.buf.signature_help, "Interactive signature help" },
                ["<space>f"] = { vim.lsp.buf.format, "Format code" },
                ["<leader>r"] = {
                    name = "refactor",
                    n = { vim.lsp.buf.rename, "Interactive rename" },
                    f = { vim.lsp.buf.format, "Format code" },
                },
                ["<leader>a"] = { vim.lsp.buf.code_action, "Interactive list of code actions" },
            }

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
                { border = "rounded" })
        end
    },
    -- LSP files operations
    {
        'antosha417/nvim-lsp-file-operations',
        event = "LspAttach",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "kyazdani42/nvim-tree.lua" },
        },
        config = function()
            require("lsp-file-operations").setup {}
        end
    },
    -- Neovim lua LSP utilities
    {
        'folke/neodev.nvim',
        ft = 'lua',
        config = function()
            require("neodev").setup {}
        end
    },
}
