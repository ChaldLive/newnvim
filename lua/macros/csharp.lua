-- ~/.config/nvim/lua/macros/csharp.lua
local M = {}

-- Insert an auto-property
function M.insert_property(name, type)
	name = name or "Property"
	type = type or "string"
	local line = ("public %s %s { get; set; }"):format(type, name)
	vim.api.nvim_put({ line }, "l", true, true)
end

-- Insert a region block
function M.insert_region(name)
	name = name or "Region"
	local lines = {
		"#region " .. name,
		"",
		"#endregion",
	}
	vim.api.nvim_put(lines, "l", true, true)
end

-- Insert a namespace block
function M.insert_namespace(name)
	name = name or "MyNamespace"
	local lines = {
		"namespace " .. name,
		"{",
		"    ",
		"}",
	}
	vim.api.nvim_put(lines, "l", true, true)
end

return M
