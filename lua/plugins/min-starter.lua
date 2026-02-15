-- ~/.config/nvim/lua/plugins/mini-starter.lua
return {
	"echasnovski/mini.starter",
	event = "VimEnter",
	config = function()
		local starter = require("mini.starter")

		starter.setup({
			header = table.concat({
				"   ███╗   ██╗███████╗██╗   ██╗██╗███╗   ███╗",
				"   ████╗  ██║██╔════╝██║   ██║██║████╗ ████║",
				"   ██╔██╗ ██║█████╗  ██║   ██║██║██╔████╔██║",
				"   ██║╚██╗██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║",
				"   ██║ ╚████║███████╗ ╚████╔╝ ██║██║ ╚═╝ ██║",
				"   ╚═╝  ╚═══╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
				"",
				"       ",
			}, "\n"),

			items = {
				-- Telescope section
				{
					name = "Find File",
					action = "Telescope find_files",
					section = "Telescope",
				},
				{
					name = "Recent Files",
					action = "Telescope oldfiles",
					section = "Telescope",
				},
				{
					name = "Grep Text",
					action = "Telescope live_grep",
					section = "Telescope",
				},

				-- Writing workflow
				{
					name = "New Markdown Note",
					action = "enew | set ft=markdown",
					section = "Writing",
				},

				-- Built-in actions
				starter.sections.builtin_actions().edit,
				starter.sections.builtin_actions().quit,
			},

			footer = function()
				return "Neovim loaded at " .. os.date("%H:%M")
			end,
		})
	end,
}
