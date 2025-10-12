return {
	{
		"catppuccin/nvim",
		priority = 1000,
		opts = function()
			return {
				transparent_background = true,
				flavour = "frappe",
				integrations = {
					bufferline = true, -- Enable bufferline integration
					treesitter = true,
					telescope = {
						enabled = true,
					},
				},
				-- },
			}
		end,
		config = function(_, opts)
			require("catppuccin").setup(opts)
			-- This section is crucial for passing the colors to bufferline.nvim
			vim.cmd.colorscheme("catppuccin")
			require("bufferline").setup({
				options = {
					separator_style = "slant",
					highlights = {
						fill = {
							bg = require("catppuccin.palettes").get_palette().base,
						},
					},
				},
			})
		end,
	},
}
-- {
-- 	"folke/tokyonight.nvim",
-- 	lazy = true,
-- 	priority = 1000,
-- 	opts = function()
-- 		return {
-- 			transparent = false,
-- 		}
-- 	end,
-- 	{
-- 		"alexanderjeurissen/lumiere.vim",
-- 		lazy = true,
-- 		priority = 1000,
--     -- use config instead of opts for vim
-- 		config = function()
-- 			return {
-- 				transparent = false,
-- 			}
-- 		end,
-- 	},
--
-- 	{
-- 		"craftzdog/solarized-osaka.nvim",
-- 		lazy = true,
-- 		priority = 1000,
-- 		opts = function()
-- 			return { transparent = true }
-- 		end,
-- 	},
--
-- 	{
-- 		"shaunsingh/nord.nvim",
-- 		lazy = true,
-- 		priority = 1000,
-- 		opts = function()
-- 			return { transparent = true }
-- 		end,
-- 	},
