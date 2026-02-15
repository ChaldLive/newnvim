
-- Mini.lua for all the fun stuff in my system
return {
  {
    "echasnovski/mini.nvim",
    version = false,

    config = function()
      ----------------------------------------------------------------------
      -- Core editing modules
      ----------------------------------------------------------------------
      require("mini.ai").setup()
      require("mini.surround").setup()
      require("mini.comment").setup()
      require("mini.pairs").setup()

      ----------------------------------------------------------------------
      -- Mini.files with custom split actions (from utils/mini_files.lua)
      ----------------------------------------------------------------------
      local mf_utils = require("utils.mini_files")

      require("mini.files").setup({
        mappings = {
          go_in_split  = "-",  -- horizontal split
          go_in_vsplit = "|",  -- vertical split
        },
      })

      -- Wire custom actions
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesAction",
        callback = function(event)
          if event.data.action == "go_in_split" then
            mf_utils.open_in_split()
          elseif event.data.action == "go_in_vsplit" then
            mf_utils.open_in_vsplit()
          end
        end,
      })

      ----------------------------------------------------------------------
      -- Mini.pick global configuration
      -- IMPORTANT: This does NOT start a picker. It only configures it.
      ----------------------------------------------------------------------
      require("mini.pick").setup({
        use_ui_select = false,   -- Force Mini.pick to use its own picker
      })

      ----------------------------------------------------------------------
      -- Statusline Enhancements
      ----------------------------------------------------------------------
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
      -- Statusline Highlights
      ----------------------------------------------------------------------
      vim.api.nvim_set_hl(0, "MiniStatuslineMode",     { fg = "#1e1e2e", bg = "#89b4fa", bold = true })
      vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo",  { fg = "#cdd6f4", bg = "#313244" })
      vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = "#f5e0dc", bg = "#45475a" })
      vim.api.nvim_set_hl(0, "MiniStatuslineLocation", { fg = "#cdd6f4", bg = "#313244" })
      vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { fg = "#6c7086", bg = "#1e1e2e" })

      ----------------------------------------------------------------------
      -- Floating notifications
      ----------------------------------------------------------------------
      require("mini.notify").setup()
      vim.notify = require("mini.notify").make_notify()
    end,
  },
}
