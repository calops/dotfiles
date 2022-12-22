-- General LSP setup
return {
	"williamboman/mason-lspconfig.nvim",
	config = function()
		local mason = require("mason-lspconfig")
		mason.setup({ automatic_installation = true })

		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		local lspconfig = require("lspconfig")

		lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
			capabilities = capabilities,
		})

		for _, server in ipairs(mason.get_installed_servers()) do
			if server ~= "rust_analyzer" then
				lspconfig[server].setup({})
			end
		end

		require("lspconfig").sumneko_lua.setup({
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
}
