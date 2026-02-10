
return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "rust_analyzer",
        },
        -- IMPORTANT: disable automatic_enable (only works on 0.11+)
        automatic_installation = false,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Rust
      lspconfig.rust_analyzer.setup({
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
          },
        },
      })
    end,
  },

  -- Required for nvim-dap-ui
  {
    "nvim-neotest/nvim-nio",
  },
}
