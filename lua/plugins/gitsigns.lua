return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },

		opts = {
			attach_to_untracked = true,
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "▎" },
				topdelete = { text = "▎" },
				changedelete = { text = "▎" },
			},
		},

		config = function(_, opts)
			require("gitsigns").setup(opts)

			-- Apply highlight overrides for ALL gitsigns groups
			local function set_gitsigns_hl()
				local colors = {
					add = "#a6e3a1",
					change = "#89b4fa",
					delete = "#f38ba8",
				}

				local groups = {
					Add = { "GitSignsAdd", "GitSignsAddLn", "GitSignsAddNr" },
					Change = { "GitSignsChange", "GitSignsChangeLn", "GitSignsChangeNr" },
					Delete = { "GitSignsDelete", "GitSignsDeleteLn", "GitSignsDeleteNr" },
				}

				for kind, names in pairs(groups) do
					for _, group in ipairs(names) do
						vim.api.nvim_set_hl(0, group, { fg = colors[kind:lower()], bold = true })
					end
				end
			end

			-- Apply immediately
			set_gitsigns_hl()

			-- Reapply after any colorscheme change
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					vim.schedule(set_gitsigns_hl)
				end,
			})
		end,
	},
}
