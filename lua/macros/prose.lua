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
-- Adding table to markdown docs, the easy way.
-- Caution. This only works for markdown docs.
local function make_cell(width)
	return string.rep(" ", width)
end

local function make_row(cols, width)
	local cells = {}
	for _ = 1, cols do
		table.insert(cells, make_cell(width))
	end
	return "| " .. table.concat(cells, " | ") .. " |"
end

local function make_separator(cols, width)
	local cells = {}
	for _ = 1, cols do
		table.insert(cells, string.rep("-", width))
	end
	return "| " .. table.concat(cells, " | ") .. " |"
end

function M.insert_table(cols, rows, headers, width)
	cols = tonumber(cols) or 3
	rows = tonumber(rows) or 3
	width = tonumber(width) or 6
	headers = headers == "true" or headers == "1" or headers == "yes"

	local lines = {}

	if headers then
		table.insert(lines, make_row(cols, width)) -- header row
		table.insert(lines, make_separator(cols, width)) -- separator
	end

	for _ = 1, rows do
		table.insert(lines, make_row(cols, width))
	end

	vim.api.nvim_put(lines, "l", true, true)
end

return M
