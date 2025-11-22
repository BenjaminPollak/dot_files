return {
	{
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")

			-- Configure formatters by filetype
			conform.setup({
				log_level = vim.log.levels.DEBUG,
				formatters_by_ft = {
					-- future languages can be added here, e.g.:
					-- go = { "gofmt" },
					-- javascript = { "prettier" },
					-- sh = { "shfmt" },
					python = { "black" },
					formatters = {
						black = {
							command = function()
								-- Prefer project venv
								local buf_dir = vim.fn.expand("%:p:h")
								local venv_black = buf_dir .. "/.venv/bin/black"
								if vim.fn.executable(venv_black) == 1 then
									return venv_black
								end

								-- Mason-installed black
								local mason_black = vim.fn.stdpath("data") .. "/mason/bin/black"
								if vim.fn.executable(mason_black) == 1 then
									return mason_black
								end
								-- System black fallback
								if vim.fn.executable("black") == 1 then
									return "black"
								end
								vim.notify("Black formatter not found!", vim.log.levels.WARN)
								return nil
							end,
							args = { "--fast" },
						},
						-- future formatter configs can be added here
					},
				},
			})

			-- Manual format function
			local M = {}
			function M.format()
				local ok, conform_mod = pcall(require, "conform")
				if ok and conform_mod.format then
					conform_mod.format({ async = false, lsp_fallback = false })
				else
					vim.notify("Conform not available, skipping formatting", vim.log.levels.WARN)
				end
			end

			-- Create :Format command
			vim.api.nvim_create_user_command("Format", function()
				M.format()
			end, {})

			-- Autoformat on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.py", -- can be expanded per language later
				callback = function()
					M.format()
				end,
			})
			return M
		end,
	},
}
