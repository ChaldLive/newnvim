-- ~/.config/nvim/lua/live-commands.lua

local live = require("live-commands")
local macros = require("macros")

-- Collect all macro names for completion
local function collect()
	local list = {}
	for module_name, module in pairs(macros) do
		for fn_name, fn in pairs(module) do
			if type(fn) == "function" then
				table.insert(list, module_name .. "." .. fn_name)
			end
		end
	end
	table.sort(list)
	return list
end

-- Parse "<module>.<function> arg1 arg2 ..."
local function parse(input)
	local parts = vim.split(input, " ", { trimempty = true })
	local head = parts[1]
	local args = {}

	for i = 2, #parts do
		table.insert(args, parts[i])
	end

	local mod_fn = vim.split(head, ".", { plain = true })
	return mod_fn[1], mod_fn[2], args
end

live.setup({
	commands = {
		Macro = {
			args = function(input)
				return collect()
			end,
			fn = function(input)
				local module, fn, args = parse(input)
				local mod = macros[module]
				if not mod then
					print("Unknown module: " .. module)
					return
				end
				local func = mod[fn]
				if not func then
					print("Unknown macro: " .. module .. "." .. fn)
					return
				end
				func(unpack(args))
			end,
			description = "Run a macro from the macros/ folder",
		},
	},
})
