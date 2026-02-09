-- init.lua

-- Leaders FIRST
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Lazy SECOND
require("config.lazy")

-- Everything else AFTER Lazy
require("options")
require("keymap")

