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
          "cspell",
          "gopls",
          "lua_ls",
          "pyright",
          "sqlls",
          "terraformls",
          "ts_ls",
          "yamlls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local util = require("lspconfig.util")

      local lspconfig = require("lspconfig")
      lspconfig.bashls.setup({
        capabilities = capabilities,
      })
      lspconfig.cspell.setup({
        capabilities = capabilities,
      })
      lspconfig.gopls.setup({
        -- ...some other setups
        root_dir = function(fname)
          -- see: https://github.com/neovim/nvim-lspconfig/issues/804
          local mod_cache = vim.trim(vim.fn.system("go env GOMODCACHE"))
          if fname:sub(1, #mod_cache) == mod_cache then
            local clients = vim.lsp.get_active_clients({ name = "gopls" })
            if #clients > 0 then
              return clients[#clients].config.root_dir
            end
          end
          return util.root_pattern("go.work")(fname) or util.root_pattern("go.mod", ".git")(fname)
        end,
        capabilities = capabilities,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })
      lspconfig.terraformls.setup({
        capabilities = capabilities,
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.yamlls.setup({
        capabilities = capabilities,
      })
      lspconfig.sqlls.setup({
        capabilities = capabilities,
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
