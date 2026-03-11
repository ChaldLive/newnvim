-- ~/.config/nvim/lua/live_commands.lua

local live = require("live-command")
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
	local parts = vim.split(input, "%s+", { trimempty = true })
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
			-- v2 API: completion(ctx)
			completion = function(ctx)
				local parts = vim.split(ctx.args, "%s+", { trimempty = true })

				-- Only complete the macro name
				if #parts <= 1 then
					return collect()
				end

				-- After first token → no completion
				return { "" }
			end,

			-- v2 API: command(ctx)
			command = function(ctx)
				local module, fn, args = parse(ctx.args)
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

return {
	collect = collect,
	parse = parse,
}
