return {
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true
		end,
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
		},
	},

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				mode = "buffers",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	-- filename
	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		priority = 1200,
		opts = {
			render = function(props)
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
				local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
				local modified = vim.bo[props.buf].modified and "bold,italic" or "bold"

				local function get_git_diff()
					local icons = { removed = "", changed = "", added = "" }
					icons["changed"] = icons.modified
					local signs = vim.b[props.buf].gitsigns_status_dict
					local labels = {}
					if signs == nil then
						return labels
					end
					for name, icon in pairs(icons) do
						if tonumber(signs[name]) and signs[name] > 0 then
							table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
						end
					end
					if #labels > 0 then
						table.insert(labels, { "┊ " })
					end
					return labels
				end
				local function get_diagnostic_label()
					local icons = { error = "", warn = "", info = "", hint = "" }
					local label = {}

					for severity, icon in pairs(icons) do
						local n = #vim.diagnostic.get(
							props.buf,
							{ severity = vim.diagnostic.severity[string.upper(severity)] }
						)
						if n > 0 then
							table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
						end
					end
					if #label > 0 then
						table.insert(label, { "┊ " })
					end
					return label
				end

				local buffer = {
					{ get_diagnostic_label() },
					{ get_git_diff() },
					{ (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
					{ filename .. " ", gui = modified },
					{ "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
				}
				return buffer
			end,
		},
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local LazyVim = require("lazyvim.util")
			opts.sections.lualine_c[4] = {
				LazyVim.lualine.pretty_path({
					length = 0,
					relative = "cwd",
					modified_hl = "MatchParen",
					directory_hl = "",
					filename_hl = "Bold",
					modified_sign = "",
					readonly_icon = " 󰌾 ",
				}),
			}
		end,
	},

	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			dashboard = {
				preset = {
					header = [[
......░░░░░░.......................░░░░░░......
.....░░░██░░░............. .......░░░██░░░.....
....░░░████░░░░░░░░░░░░░░░░░░░░░░░░░████░░░....
....░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░....
....░░░░░░░░░░███░░░░░░░░░░░███░░░░░░░░░░░░....
...░░░░░░░░███░▒░███░░░░░███░▒░███░░░░░░░░░░...
..░░░░░░░░██░░░█░░░██░░░██░░░█░░░██░░░░░░░░░░..
░░░░░░░░░░░███░░░███░░█░░███░░░███░░░░░░░░░░░░░
.░░░░░░░░░░░░░███░░░░█░█░░░░███░░░░░░░░░░░░░░░.
..░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░..
..░░░░░░░░░░░░░░░█░░░░░░░░░░░░░░░░░░░░░░░░░░░..
..░░░░░░░░░░░░░░░░██░░░░░░░░░░░░░░░░░░░░░░░░░..
..░░░░░░░░░░░░░░░░░░██░░░░░░░░░░░░░░░░░░░░░░░..
..░░░░░░░░░░░░░░░░██▒░░░░░░░░░░░░░░░░░░░░░░░░..
...░░░░░░░░░░░░░░█░░░░░░░░░░░░░░░░░░░░░░░░░░...
....░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░....
.....░░░░░░.........................░░░░░░.....
          ]],
				},
			},
		},
	},
}
