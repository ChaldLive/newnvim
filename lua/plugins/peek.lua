-- lua/plugins/peek.lua. markdown nice stuff
return {

	"toppair/peek.nvim",
	build = "deno task --quiet build:fast",
	config = function()
		require("peek").setup({
			theme = "dark", -- or "light"
			app = "webview", -- or "browser" if you prefer external preview
		})

		-- Optional: Add easy commands
		vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
		vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
	end,
	ft = { "markdown" },
}
