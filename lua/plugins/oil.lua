-- oil.lua — buffer‑native file explorer
return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },

		config = function()
			require("oil").setup({
				default_file_explorer = true, -- replaces netrw
				columns = {
					"icon", -- file icons
					--					"permissions",
					--					"size",
					--					"mtime",
				},

				view_options = {
					show_hidden = false,
				},

				keymaps = {
					["<CR>"] = "actions.select",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["g."] = "actions.toggle_hidden",
				},

				float = {
					padding = 2,
					max_width = 80,
					max_height = 40,
					border = "rounded",
					win_options = {
						winblend = 0,
					},
				},

				win_options = {
					wrap = false,
					signcolumn = "no",
				},
			})

			-- Keymap: open Oil in the current directory
			vim.keymap.set("n", "<leader>e", function()
				require("oil").open()
			end, { desc = "Open Oil file explorer" })
		end,
	},
}
