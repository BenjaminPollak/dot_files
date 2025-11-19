return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
			})
		end,
	},
	{
		-- TODO: make this apply only to css files
		"catgoose/nvim-colorizer.lua",
		ft = { "css" },
		event = "BufReadPre",
		opts = { -- set to setup table
		},
		config = function()
			require("colorizer").setup({
				filetypes = { "css" },
				user_default_options = {
					names = true,
					RGB = true,
					RRGGBB = true,
					RRGGBBAA = true,
					AARRGGBB = true,
					css = true,
					css_fn = true,
				},
			})
		end,
	},
}
