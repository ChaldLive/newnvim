-- ~/.config/nvim/lua/utils/mini_files.lua

local M = {}

local MiniFiles = require("mini.files")

-- Open file in horizontal split
function M.open_in_split()
  local entry = MiniFiles.get_fs_entry()
  if entry and entry.path then
    vim.cmd("split")
    vim.cmd("edit " .. vim.fn.fnameescape(entry.path))
  end
end

-- Open file in vertical split
function M.open_in_vsplit()
  local entry = MiniFiles.get_fs_entry()
  if entry and entry.path then
    vim.cmd("vsplit")
    vim.cmd("edit " .. vim.fn.fnameescape(entry.path))
  end
end

return M
