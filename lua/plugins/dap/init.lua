-- lua/plugins/dap/init.lua
return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,  -- ensure signs load BEFORE first breakpoint
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Core UI setup
      dapui.setup()

      -- Auto-open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      ------------------------------------------------------------------
      -- 🔵🔴🟡 Colored Circular DAP Signs
      ------------------------------------------------------------------

      vim.fn.sign_define("DapBreakpoint", {
        text = "●",
        texthl = "ErrorMsg",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapBreakpointCondition", {
        text = "●",
        texthl = "WarningMsg",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapStopped", {
        text = "●",
        texthl = "MoreMsg",
        linehl = "CursorLine",
        numhl = "",
      })
    end,
  },

  -- Load language-specific DAP configs
  { import = "plugins.dap.rust" },
}
