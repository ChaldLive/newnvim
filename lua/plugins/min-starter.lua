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
				-- Snacks picker section
				{
					name = "Find File",
					action = function()
						Snacks.picker.files()
					end,
					section = "Snacks",
				},
				{
					name = "Recent Files",
					action = function()
						Snacks.picker.recent()
					end,
					section = "Snacks",
				},
				{
					name = "Grep Text",
					action = function()
						Snacks.picker.grep()
					end,
					section = "Snacks",
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
