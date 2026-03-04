-- ~/.config/nvim/lua/macro_commands.lua
local function collect_all_macros()
	local macros = require("macros")
	local list = {}

	for mod_name, mod in pairs(macros) do
		for fn_name, _ in pairs(mod) do
			table.insert(list, mod_name .. "." .. fn_name)
		end
	end

	return list
end

vim.api.nvim_create_user_command("Macro", function(opts)
	local macros = require("macros")
	local parts = vim.split(opts.args, ".", { plain = true })

	local mod = macros[parts[1]]
	local fn = mod and mod[parts[2]]

	if fn then
		fn()
	else
		print("Unknown macro: " .. opts.args)
	end
end, {
	nargs = 1,
	complete = function()
		return collect_all_macros()
	end,
})
