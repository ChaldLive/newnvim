-- ~/.config/nvim/lua/macros/prose.lua
local M = {}

-- Reflow the current paragraph to a fixed width (default 80)
function M.reflow(width)
	width = tonumber(width) or 80
	vim.cmd("normal! gqap")
end

-- Toggle between single and double quotes on the current line
function M.toggle_quotes()
	local line = vim.api.nvim_get_current_line()
	local swapped = line:gsub('"(.-)"', "'%1'"):gsub("'(.-)'", '"%1"')
	vim.api.nvim_set_current_line(swapped)
end

-- Trim trailing whitespace in the whole file
function M.trim_trailing()
	vim.cmd([[%s/\s\+$//e]])
end

-- Surround the word under cursor with given characters
function M.surround(left, right)
	left = left or "("
	right = right or ")"
	vim.cmd("normal! viw" .. "s" .. left .. "\\0" .. right)
end

return M
