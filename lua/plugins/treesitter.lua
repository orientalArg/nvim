return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		-- LazyVim config for treesitter
		indent = { enable = true },
		highlight = { enable = true },
		folds = { enable = true },
		ensure_installed = {
			"cmake",
			"http",
			"css",
			"scss",
			"javascript",
			"json",
			"jsdoc",
			"astro",
			"svelte",
			"typescript",
			"tsx",
			"gitignore",
			"sql",
		},
	},
}
