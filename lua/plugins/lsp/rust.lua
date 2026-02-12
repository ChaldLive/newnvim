-- lua/plugins/lsp/rust.lua
return {
  "neovim/nvim-lspconfig",
  ft = "rust",
  config = function()
    -- 1. Define the server using the new API
    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          cargo = { allFeatures = true },
          check = { command = "clippy" },
        },
      },
    })

    -- 2. Load lspconfig *after* defining the server
    local lspconfig = require("lspconfig")

    -- 3. Start the server (no warning, workspace detection works)
    lspconfig.rust_analyzer.setup({})
  end,
}
