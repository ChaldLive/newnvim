-- ~/.config/nvim/lua/plugins/mason-lspconfig.lua

return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },

	config = function()
		-- Custom server settings go here via vim.lsp.config (Neovim 0.11+).
		-- mason-lspconfig's automatic_enable will call vim.lsp.enable() for
		-- each installed server, picking up these settings automatically.
		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					cargo = { allFeatures = true },
					check = { command = "clippy" },
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "ts_ls", "pyright" },
		})
	end,
}
