return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#292c3c',
				base01 = '#292c3c',
				base02 = '#9d9391',
				base03 = '#9d9391',
				base04 = '#fef1ee',
				base05 = '#fff9f8',
				base06 = '#fff9f8',
				base07 = '#fff9f8',
				base08 = '#ffa19f',
				base09 = '#ffa19f',
				base0A = '#ffe5df',
				base0B = '#b7ffa5',
				base0C = '#fff1ee',
				base0D = '#ffe5df',
				base0E = '#ffe9e5',
				base0F = '#ffe9e5',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#9d9391',
				fg = '#fff9f8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#ffe5df',
				fg = '#292c3c',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#9d9391' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#fff1ee', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#ffe9e5',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#ffe5df',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#ffe5df',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#fff1ee',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#b7ffa5',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#fef1ee' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#fef1ee' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#9d9391',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
