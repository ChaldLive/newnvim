-- ~/.config/nvim/lua/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },

  opts = {
    notify_on_error = false,

    format_on_save = function(bufnr)
      -- Disable for large files
      if vim.api.nvim_buf_line_count(bufnr) > 5000 then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,

    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      toml = { "taplo" },
      csharp = { "csharpier" },
      java = { "google-java-format" },
    },
  },
}
