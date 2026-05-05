-- ~/.config/nvim/lua/plugins/live-commands.lua

return {
	{
		"smjonas/live-command.nvim",
		config = function()
			require("live-command").setup({
				commands = {
					Norm = { cmd = "norm" },
					G = { cmd = "g" },
					Sub = { cmd = "s" },
				},
			})
		end,
	},
}
