-- lua/plugins/dap/init.lua
return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },

    keys = {
      { "<F5>",       function() require("dap").continue() end,                                        desc = "DAP: Continue" },
      { "<F10>",      function() require("dap").step_over() end,                                       desc = "DAP: Step over" },
      { "<F11>",      function() require("dap").step_into() end,                                       desc = "DAP: Step into" },
      { "<F12>",      function() require("dap").step_out() end,                                        desc = "DAP: Step out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                               desc = "Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end,       desc = "Conditional breakpoint" },
      { "<leader>dc", function() require("dap").run_to_cursor() end,                                   desc = "Run to cursor" },
      { "<leader>du", function() require("dapui").toggle() end,                                        desc = "Toggle DAP UI" },
    },

    config = function()
      local dap    = require("dap")
      local dapui  = require("dapui")

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end

      vim.fn.sign_define("DapBreakpoint",          { text = "●", texthl = "ErrorMsg" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "●", texthl = "WarningMsg" })
      vim.fn.sign_define("DapBreakpointRejected",  { text = "✖", texthl = "ErrorMsg" })
      vim.fn.sign_define("DapStopped",             { text = "●", texthl = "MoreMsg", linehl = "CursorLine" })

      -- -----------------------------------------------------------------------
      -- Rust — lldb-dap via Homebrew LLVM (stdio mode, required on ARM macOS)
      -- -----------------------------------------------------------------------
      dap.adapters.lldb = {
        type    = "executable",
        command = "/opt/homebrew/opt/llvm/bin/lldb-dap",
        name    = "lldb",
      }

      -- Auto-detect the cargo binary from metadata; falls back to a prompt.
      local function cargo_binary()
        local meta = vim.fn.system("cargo metadata --no-deps --format-version 1 2>/dev/null")
        local ok, data = pcall(vim.json.decode, meta)
        if ok and data and data.packages and data.packages[1] then
          local name = data.packages[1].name:gsub("%-", "_")
          local bin  = data.target_directory .. "/debug/" .. name
          if vim.fn.filereadable(bin) == 1 then return bin end
        end
        return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
      end

      dap.configurations.rust = {
        {
          name        = "Debug",
          type        = "lldb",
          request     = "launch",
          program     = cargo_binary,
          cwd         = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          name        = "Debug (with args)",
          type        = "lldb",
          request     = "launch",
          program     = cargo_binary,
          args        = function()
            return vim.split(vim.fn.input("Args: "), " ", { trimempty = true })
          end,
          cwd         = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
    end,
  },
}
