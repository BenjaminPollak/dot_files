local function find_project_root()
	local dir = vim.fn.expand("%:p:h") -- start at current buffer's directory
	while dir ~= "/" do
		-- check for package.json (JS/TS) or pyproject.toml (Python)
		if vim.fn.filereadable(dir .. "/package.json") == 1 or vim.fn.filereadable(dir .. "/pyproject.toml") == 1 then
			return dir
		end
		-- move up one directory
		dir = vim.fn.fnamemodify(dir, ":h")
	end
	return nil -- not found
end

return {
	{
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")

			-- Setup formatters
			conform.setup({
				log_level = vim.log.levels.DEBUG,
				formatters_by_ft = {
					go = {
            "goimports",
            "gofmt",
          },
					python = { "black" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					json = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
				},
				-- Optional: define custom commands for formatters
				formatters = {
					black = {
						command = function()
							local buf_dir = vim.fn.expand("%:p:h")
							local venv_black = buf_dir .. "/.venv/bin/black"
							if vim.fn.executable(venv_black) == 1 then
								return venv_black
							end
							local mason_black = vim.fn.stdpath("data") .. "/mason/bin/black"
							if vim.fn.executable(mason_black) == 1 then
								return mason_black
							end
							if vim.fn.executable("black") == 1 then
								return "black"
							end
							vim.notify("Black formatter not found!", vim.log.levels.WARN)
							return nil
						end,
						args = { "--fast", "-" },
						stdin = true,
					},
					prettier = {
						command = function()
							local root = find_project_root()
							if root then
								local project_prettier = root .. "/node_modules/.bin/prettier"
								if vim.fn.executable(project_prettier) == 1 then
									return project_prettier
								end
							end

							-- fallback to global or Mason
							if vim.fn.executable("prettier") == 1 then
								return "prettier"
							end
							local mason_prettier = vim.fn.stdpath("data") .. "/mason/bin/prettier"
							if vim.fn.executable(mason_prettier) == 1 then
								return mason_prettier
							end
							vim.notify("Prettier not found!", vim.log.levels.WARN)
							return nil
						end,
						args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
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
				pattern = {
					"*.py",
					"*.js",
					"*.ts",
					"*.jsx",
					"*.tsx",
					"*.json",
					"*.css",
					"*.html",
          "*.go",
				},
				callback = function()
					M.format()
				end,
			})

			return M
		end,
	},
}
