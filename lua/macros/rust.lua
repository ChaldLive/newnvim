-- ~/.config/nvim/lua/macros/rust.lua
local M = {}

-- Insert a basic Rust module template
function M.insert_module(name)
	name = name or "module"
	local lines = {
		"pub mod " .. name .. " {",
		"    use super::*;",
		"",
		"}",
	}
	vim.api.nvim_put(lines, "l", true, true)
end

-- Expand a match arm placeholder into a full block
function M.expand_match()
	local template = {
		"{",
		"    // TODO: implement",
		"}",
	}
	vim.api.nvim_put(template, "l", true, true)
end

-- Toggle between `Some(x)` and `Ok(x)`
function M.toggle_result_option()
	local line = vim.api.nvim_get_current_line()
	if line:match("Some%(") then
		line = line:gsub("Some%(", "Ok(")
	elseif line:match("Ok%(") then
		line = line:gsub("Ok%(", "Some(")
	end
	vim.api.nvim_set_current_line(line)
end

return M
