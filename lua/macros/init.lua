-- ~/.config/nvim/lua/macros/init.lua
local M = {}

local macro_dir = vim.fn.stdpath("config") .. "/lua/macros"

for _, file in ipairs(vim.fn.readdir(macro_dir)) do
	if file:match("%.lua$") and file ~= "init.lua" then
		local name = file:gsub("%.lua$", "")
		M[name] = require("macros." .. name)
	end
end

return M
