-- Rust-specific utilities and LSP configurations
return {
	"simrat39/rust-tools.nvim",
	ft = "rust",
	config = function()
		local custom_lsp_conf
		if vim.fn.filereadable(".lsp.lua") == true then
			custom_lsp_conf = dofile(".lsp.lua")
		else
			custom_lsp_conf = {}
		end
		local rust_lsp_conf = vim.tbl_extend("force", {
			rustfmt = {
				extraArgs = {
					"--config",
					"comment_width=120,condense_wildcard_suffixes=false,format_code_in_doc_comments=true,format_macro_bodies=true,hex_literal_case=Upper,imports_granularity=One,normalize_doc_attributes=true,wrap_comments=true",
				},
			},
			semanticHighlighting = {
				["punctuation.enable"] = true,
				["punctuation.separate.macro.bang"] = true,
			},
		}, custom_lsp_conf)

		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		require("rust-tools").setup({
			tools = {
				inlay_hints = { highlight = "InlayHints" },
			},
			server = {
				capabilities = capabilities,
				settings = { ["rust-analyzer"] = rust_lsp_conf },
			},
		})
		-- Auto format on save, rust files only
		require("core.autocmd").BufWritePost = {
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
}
