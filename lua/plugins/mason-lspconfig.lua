-- ~/.config/nvim/lua/plugins/mason-lspconfig.lua

return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = { "williamboman/mason.nvim" },

	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"pyright",
			},

			handlers = {
				function(server)
					require("lspconfig")[server].setup({})
				end,

				rust_analyzer = function()
					require("lspconfig").rust_analyzer.setup({
						settings = {
							["rust-analyzer"] = {
								cargo = { allFeatures = true },
								check = { command = "clippy" },
							},
						},
					})
				end,
			},
		})
	end,
}
