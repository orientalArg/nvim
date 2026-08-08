local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
vim.o.background = "dark"

require("lazy").setup({
	spec = {
		{
			"LazyVim/LazyVim",
			import = "lazyvim.plugins",
			opts = {
				-- change one of the colorscheme to change theme, if you have a quickshell distro then uncomment to enable automatic theme change
				colorscheme = "catppuccin",
				-- colorscheme = "gruvbox",
				-- colorscheme = "lumiere",
				-- colorscheme = "base16-catppuccin-mocha",
				-- colorscheme = "tokyonight-moon",
				news = {
					lazyvim = true,
					neovim = true,
				},
			},
		},
		-- import any extras modules here
		{ import = "lazyvim.plugins.extras.linting.eslint" },
		{ import = "lazyvim.plugins.extras.formatting.prettier" },
		{ import = "lazyvim.plugins.extras.lang.typescript" },
		{ import = "lazyvim.plugins.extras.lang.json" },
		{ import = "lazyvim.plugins.extras.lang.tailwind" },
		{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },
		{ import = "plugins" },
	},

	defaults = {
		lazy = false,
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},

	dev = {
		path = "~/.ghq/github.com",
	},

	checker = { enabled = false }, -- automatically check for plugin updates

	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"zipPlugin",
				"tohtml",
				"tutor",
			},
		},
	},
	debug = false,
})
