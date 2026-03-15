return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,

		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",

				-- Disable integrations that overwrite your colors
				integrations = {
					gitsigns = false,
					mini = false,
				},

				-- Your custom Treesitter highlights
				custom_highlights = function(colors)
					return {
						["@keyword"] = { fg = colors.red, style = { "bold", "italic" } },
						["@keyword.function"] = { fg = colors.purple, style = { "bold", "italic" } },
						["@keyword.return"] = { fg = colors.teal, style = { "bold" } },
						["@conditional"] = { fg = colors.red, style = { "bold" } },
						["@repeat"] = { fg = colors.red, style = { "bold" } },

						["@function"] = { fg = colors.blue },
						["@variable.builtin"] = { fg = colors.mauve, style = { "italic" } },
						["@string"] = { fg = colors.green },
						["@comment"] = { fg = colors.overlay2, style = { "italic" } },
					}
				end,
			})

			-- Apply the colorscheme
			vim.cmd.colorscheme("catppuccin")

			------------------------------------------------------------------
			-- FIX: Restore UI groups Catppuccin overwrites (statusline + signs)
			------------------------------------------------------------------
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					-- Let GitSigns colors show properly
					vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })

					-- Let Mini.statusline use YOUR colors, not Catppuccin's
					vim.api.nvim_set_hl(0, "StatusLine", { bg = "#1e1e2e", fg = "#cdd6f4" })
					vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#1e1e2e", fg = "#6c7086" })
				end,
			})
		end,
	},
}
