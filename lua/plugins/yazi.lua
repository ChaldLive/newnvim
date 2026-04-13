-- ~/.config/nvim/lua/plugins/yazi.lua
-- mikavilpas/yazi.nvim — yazi terminal file manager inside Neovim
-- Requires: yazi installed (brew install yazi)
-- Requires: yazi >= 0.2.5
-- Docs: https://github.com/mikavilpas/yazi.nvim

return {
	"mikavilpas/yazi.nvim",
	version = "*", -- always use latest stable release
	event = "VeryLazy",

	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},

	keys = {
		-- Open yazi at the current file's location (your main entry point)
		{
			"<leader>e",
			"<cmd>Yazi<cr>",
			mode = { "n", "v" },
			desc = "Open yazi (current file)",
		},

		-- Open yazi at nvim's working directory (project root)
		{
			"<leader>E",
			"<cmd>Yazi cwd<cr>",
			desc = "Open yazi (cwd)",
		},

		-- Resume the last yazi session — super handy
		{
			"<leader>ye",
			"<cmd>Yazi toggle<cr>",
			desc = "Resume last yazi session",
		},
	},

	---@type YaziConfig | {}
	opts = {
		-- Open yazi instead of netrw when opening a directory
		-- (e.g. nvim .)
		open_for_directories = true,

		-- Since we're replacing netrw, tell nvim not to load it
		-- (handled in init below)

		-- Floating window size — 90% of editor is comfortable
		floating_window_scaling_factor = 0.90,

		-- Window transparency (0 = opaque, 100 = invisible)
		yazi_floating_window_winblend = 0,

		-- Border style: "none" | "single" | "double" | "rounded" | "solid"
		yazi_floating_window_border = "rounded",

		-- -----------------------------------------------------------------------
		-- What happens when you open a file in yazi
		-- Default behaviour (open in current window) is fine for most setups.
		-- Uncomment below to always open in a new tab instead:
		-- -----------------------------------------------------------------------
		-- open_file_function = function(chosen_file, config, state)
		--   vim.cmd("tabedit " .. chosen_file)
		-- end,

		-- -----------------------------------------------------------------------
		-- Keymaps INSIDE yazi
		-- These are nvim-side bindings that intercept input before yazi sees it.
		-- Only map keys yazi itself never needs.
		-- -----------------------------------------------------------------------
		keymaps = {
			show_help = "<f1>",
			open_file_in_vertical_split = "<c-v>",
			open_file_in_horizontal_split = "<c-x>",
			open_file_in_tab = "<c-t>",
			grep_in_directory = "<c-s>", -- needs snacks/telescope/fzf
			cycle_open_buffers = "<tab>",
			copy_relative_path_to_selected_files = "<c-y>",
			send_to_quickfix_list = "<c-q>",
			change_working_directory = "<c-\\>",
			open_and_pick_window = "<c-o>",
		},

		-- -----------------------------------------------------------------------
		-- Keep nvim buffers in sync with yazi file operations
		-- Renames, moves and deletes in yazi update open buffers and LSP.
		-- -----------------------------------------------------------------------
		-- (enabled by default, nothing to configure)
	},

	-- Prevent netrw from loading since yazi replaces it for directories
	init = function()
		vim.g.loaded_netrwPlugin = 1
	end,
}
