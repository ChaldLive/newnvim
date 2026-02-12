-- lua/plugins/dap/rust.lua
return {
  "mfussenegger/nvim-dap",
  dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
  ft = "rust",
  config = function()
    local dap = require("dap")

    -- Signs must be defined AFTER dap loads
    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "ErrorMsg" })
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "WarningMsg" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "✖", texthl = "ErrorMsg" })

    local dapui = require("dapui")
    dapui.setup()

    ----------------------------------------------------------------------
    -- FIX: Use stdio mode (your old working setup)
    -- Homebrew's lldb-dap does NOT support server mode on macOS ARM.
    ----------------------------------------------------------------------
    dap.adapters.lldb = {
      type = "executable",
      command = "/opt/homebrew/opt/llvm/bin/lldb-dap",
      name = "lldb",
    }

    dap.configurations.rust = {
      {
        name = "Debug",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/target/debug/",
            "file"
          )
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    -- Auto-open DAP UI when debugging starts
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
  end,
}
