-- init.lua

-- Leaders FIRST
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load context-keybinder.nvim from local development path BEFORE Lazy
local ok, ck = pcall(require, "context-keybinder-dev")
if ok and type(ck) == "table" and ck.setup then
  ck.setup({})
end

-- Temporary debug autocmd to see context switching live
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter" }, {
  callback = function()
    local ctx = require("context-keybinder.core.context").get_context()
    require("context-keybinder.core.dispatcher").apply(ctx, 0)
  end,
})

-- Lazy SECOND
require("config.lazy")

-- Everything else AFTER Lazy
require("options")
require("keymap")

-- Enable spelcheck and other cool stuff.
require("writing").setup()

-- Enable autoloading of custom macroes / commands.
require("macros")

-- Load your Live Command interface
require("live_commands")



