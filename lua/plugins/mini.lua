-- Mini.lua for all the fun stuff in my system
return {
  {
    "echasnovski/mini.nvim",
    version = false,

    config = function()
      -- Core editing modules
      require("mini.ai").setup()
      require("mini.surround").setup()
      require("mini.comment").setup()
      require("mini.pairs").setup()
      require("mini.files").setup()
      require("mini.git").setup()   -- <-- Git support added here

      ----------------------------------------------------------------------
      -- Statusline Enhancements
      ----------------------------------------------------------------------

      -- Extra components: LSP client + filetype
      local function lsp_client()
        local clients = vim.lsp.get_active_clients({ bufnr = 0 })
        if next(clients) == nil then
          return ""
        end
        return " " .. clients[1].name
      end

      local function filetype()
        return vim.bo.filetype ~= "" and (" " .. vim.bo.filetype) or ""
      end

      require("mini.statusline").setup({
        use_icons = true,

        content = {
          active = function()
            local mode = MiniStatusline.section_mode({ trunc_width = 120 })
            local git  = MiniStatusline.section_git({ trunc_width = 75 })
            local diag = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local file = MiniStatusline.section_filename({ trunc_width = 140 })
            local loc  = MiniStatusline.section_location({ trunc_width = 75 })

            return MiniStatusline.combine_groups({
              { hl = "MiniStatuslineMode",     strings = { mode } },
              { hl = "MiniStatuslineDevinfo",  strings = { git, diag, filetype(), lsp_client() } },
              "%<",
              { hl = "MiniStatuslineFilename", strings = { file } },
              { hl = "MiniStatuslineLocation", strings = { loc } },
            })
          end,
        },
      })

      ----------------------------------------------------------------------
      -- Statusline Highlights (tasteful, modern, Catppuccin‑like)
      ----------------------------------------------------------------------
      vim.api.nvim_set_hl(0, "MiniStatuslineMode",     { fg = "#1e1e2e", bg = "#89b4fa", bold = true })
      vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo",  { fg = "#cdd6f4", bg = "#313244" })
      vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = "#f5e0dc", bg = "#45475a" })
      vim.api.nvim_set_hl(0, "MiniStatuslineLocation", { fg = "#cdd6f4", bg = "#313244" })
      vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { fg = "#6c7086", bg = "#1e1e2e" })

      ----------------------------------------------------------------------
      -- Optional: floating notifications (harmless and nice)
      ----------------------------------------------------------------------
      require("mini.notify").setup()
      vim.notify = require("mini.notify").make_notify()
    end,
  },
}
