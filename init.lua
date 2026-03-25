-- init.lua

-- Leaders FIRST
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------------------------------------------------------
-- Load context-keybinder.nvim from local development path BEFORE Lazy
--
-- IMPORTANT:
-- Your dev loader already calls setup() internally.
-- So you MUST NOT wrap it in pcall or check for ck.setup.
-- Just require it directly so the plugin actually loads.
--------------------------------------------------------------------------------
require("context-keybinder-dev")

--------------------------------------------------------------------------------
-- Lazy SECOND
--------------------------------------------------------------------------------
require("config.lazy")

--------------------------------------------------------------------------------
-- Everything else AFTER Lazy
--------------------------------------------------------------------------------
require("options")
require("keymap")

-- Enable spellcheck and other cool stuff.
require("writing").setup()

-- Enable autoloading of custom macros / commands.
require("macros")

-- Load your Live Command interface
require("live_commands")
