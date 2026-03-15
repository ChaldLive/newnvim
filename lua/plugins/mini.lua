-- Mini.lua — clean, sharp, editing‑only Mini setup
return {
	{
		"echasnovski/mini.nvim",
		version = false,

		config = function()
			----------------------------------------------------------------------
			-- Core editing modules only
			----------------------------------------------------------------------

			-- Text objects and motions
			require("mini.ai").setup()

			-- Surround editing (ys, ds, cs)
			require("mini.surround").setup()

			-- Comment toggling
			require("mini.comment").setup()

			-- Auto-pairs
			require("mini.pairs").setup()

			----------------------------------------------------------------------
			-- All UI modules intentionally removed:
			--
			-- mini.files
			-- mini.pick
			-- mini.statusline
			-- mini.notify
			-- mini.tabline
			-- mini.indentscope
			-- mini.animate
			--
			-- This keeps Mini focused, predictable, and friction-free.
			----------------------------------------------------------------------
		end,
	},
}
