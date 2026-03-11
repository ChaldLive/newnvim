-- Development loader for context-keybinder.nvim

-- ~/.config/nvim/lua/context-keybinder-dev.lua

local plugin_path = "/Users/chald/work/programming/Lua/context-keybinder.nvim/lua"

-- Allow requiring "context-keybinder"
package.path = package.path .. ";" .. plugin_path .. "/?.lua"

-- Allow requiring "context-keybinder.core.context", etc.
package.path = package.path .. ";" .. plugin_path .. "/?/init.lua"
package.path = package.path .. ";" .. plugin_path .. "/?/?.lua"

return require("context-keybinder").setup({
	log_level = "off", -- or "verbose", "info", "error", "warn"
})
