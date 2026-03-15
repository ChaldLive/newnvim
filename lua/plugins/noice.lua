return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},

		config = function()
			require("noice").setup({
				-- LSP UI
				lsp = {
					progress = { enabled = false }, -- keep things quiet
					hover = { enabled = true },
					signature = { enabled = true },
					message = { enabled = true },
				},

				-- Command line & messages
				presets = {
					bottom_search = true, -- classic search UI
					command_palette = true, -- cmdline in a floating palette
					long_message_to_split = true, -- prevents "Press ENTER"
					inc_rename = false,
					lsp_doc_border = true,
				},

				-- Message routing
				messages = {
					view = "mini", -- small, unobtrusive messages
					view_error = "notify",
					view_warn = "notify",
					view_history = "messages",
					view_search = "virtualtext",
				},

				-- Notification handling
				notify = {
					enabled = true, -- Noice takes over vim.notify
				},

				-- Command line UI
				cmdline = {
					enabled = true,
					view = "cmdline",
				},
			})

			-- Use nvim-notify as backend for Noice notifications
			require("notify").setup({
				stages = "fade_in_slide_out",
				timeout = 2000,
				background_colour = "#000000",
			})
			vim.notify = require("notify")
		end,
	},
}
