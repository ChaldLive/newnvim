-- lua/plugins/mason-lspconfig.lua
return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim" },  -- FIX: remove nvim-lspconfig
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "rust_analyzer",
      },
      automatic_installation = false,
    })
  end,
}
