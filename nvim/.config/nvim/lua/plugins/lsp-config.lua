return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"cspell_ls",
					"eslint",
					"gopls",
					"lua_ls",
					"pyright",
					"ruff",
					"sqlls",
					"stylua",
					"terraformls",
					"ts_ls",
					"yamlls",
				},
				automatic_isntallation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("bashls", {
				capabilities = capabilities,
			})
			vim.lsp.config("cspell_ls", {
				capabilities = capabilities,
			})
			vim.lsp.config("eslint", {
				capabilities = capabilities,
			})
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})
			-- Pyright (Type Checking Only)
			vim.lsp.config("pyright", {
				capabilities = capabilities,
				venvPath = ".",
				venv = ".venv",
				pythonPath = "./.venv/bin/python",
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
						},
					},
				},
			})
			-- Ruff (Linting, Import Sorting, Fixes — NO formatting)
			vim.lsp.config("ruff_lsp", {
				capabilities = capabilities,
				init_options = {
					settings = {
						args = { "--no-format" },
					},
				},
			})
			vim.lsp.config("stylua", {
				capabilities = capabilities,
			})
			vim.lsp.config("terraformls", {
				capabilities = capabilities,
			})
			vim.lsp.config("tsserver", { -- alias of ts_ls
				cmd = { "typescript-language-server", "--stdio" },
				root_dir = function()
					local root = vim.fs.find({ "tsconfig.json", "package.json" }, { upward = true })[1]
					return root and vim.fs.dirname(root) or vim.fn.getcwd()
				end,
			})
			vim.lsp.config("yamlls", {
				capabilities = capabilities,
			})
			vim.lsp.config("sqlls", {
				capabilities = capabilities,
			})
			--local lspconfig = require("lspconfig")
			--local util = require("lspconfig.util")
			--lspconfig.gopls.setup({
			--  -- ...some other setups
			--  root_dir = function(fname)
			--    -- see: https://github.com/neovim/nvim-lspconfig/issues/804
			--    local mod_cache = vim.trim(vim.fn.system("go env GOMODCACHE"))
			--    if fname:sub(1, #mod_cache) == mod_cache then
			--      local clients = vim.lsp.get_active_clients({ name = "gopls" })
			--      if #clients > 0 then
			--        return clients[#clients].config.root_dir
			--      end
			--    end
			--    return util.root_pattern("go.work")(fname) or util.root_pattern("go.mod", ".git")(fname)
			--  end,
			--  capabilities = capabilities,
			--})
			vim.lsp.config("gopls", {
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
