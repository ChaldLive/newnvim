-- lua/plugins/lsp/rust.lua
return {
	"neovim/nvim-lspconfig",
	ft = "rust",
	config = function()
		-- Define and start rust-analyzer using the new Neovim LSP API
		vim.lsp.start({
			name = "rust_analyzer",
			cmd = { "rust-analyzer" },
			root_dir = vim.fs.root(0, { "Cargo.toml", ".git" }),
			settings = {
				["rust-analyzer"] = {
					cargo = { allFeatures = true },
					check = { command = "clippy" },
				},
			},
		})
	end,
}
