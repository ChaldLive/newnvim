-- options.lua

local o = vim.opt

o.number = true
o.relativenumber = true
o.mouse = "a"
o.clipboard = "unnamedplus"
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true
o.termguicolors = true
o.signcolumn = "yes"
o.undofile = true
o.undodir = vim.fn.stdpath("state") .. "/undo"
