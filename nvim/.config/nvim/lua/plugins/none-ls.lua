return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"davidmh/cspell.nvim",
	},
	opts = function(_, opts)
		local cspell = require("cspell")
		opts.sources = opts.sources or {}
		table.insert(
			opts.sources,
			cspell.diagnostics.with({
				diagnostics_postprocess = function(diagnostic)
					diagnostic.severity = vim.diagnostic.severity.HINT
				end,
			})
		)
		table.insert(opts.sources, cspell.code_actions)
	end,
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.goimports,
				require("cspell").diagnostics,
				require("cspell").code_actions,
			},
			-- you can reuse a shared lspconfig on_attach callback here
			on_attach = function(client, bufnr)
				if client.supports_method and client:supports_method("textDocument/hover") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
							-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})

		-- run formatters on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				local clients = vim.lsp.get_active_clients({ bufnr = 0 })
				for _, client in ipairs(clients) do
					if client.name == "null-ls" then
						vim.lsp.buf.format({ async = false })
					end
				end
			end,
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
