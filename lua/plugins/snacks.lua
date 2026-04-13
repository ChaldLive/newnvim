-- ~/.config/nvim/lua/plugins/snacks.lua
-- folke/snacks.nvim — a collection of QoL plugins in one
-- Docs: https://github.com/folke/snacks.nvim
--
-- IMPORTANT: priority = 1000, lazy = false
-- snacks needs to load early so other plugins (like claudecode.nvim)
-- can use it as a dependency without timing issues.

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	---@type snacks.Config
	opts = {

		-- -----------------------------------------------------------------------
		-- bigfile
		-- Disables heavy features (LSP, treesitter, etc.) for large files
		-- so Neovim doesn't choke opening a 10MB log file.
		-- -----------------------------------------------------------------------
		bigfile = { enabled = true },

		-- -----------------------------------------------------------------------
		-- dashboard
		-- Startup screen. Shows recent files, sessions, shortcuts.
		-- -----------------------------------------------------------------------
		dashboard = {
			enabled = true,
			-- Uncomment to customise the sections shown on the dashboard:
			-- sections = {
			--   { section = "header" },
			--   { section = "keys", gap = 1 },
			--   { section = "recent_files", limit = 5, padding = 1 },
			--   { section = "startup" },
			-- },
		},

		-- -----------------------------------------------------------------------
		-- explorer
		-- Lightweight file tree (alternative to nvim-tree / neo-tree).
		-- Toggle with <leader>e (see keys below).
		-- -----------------------------------------------------------------------
		explorer = { enabled = false },

		-- -----------------------------------------------------------------------
		-- indent
		-- Indent guides with scope highlighting.
		-- -----------------------------------------------------------------------
		indent = {
			enabled = true,
			indent = { char = "│" }, -- guide character
			scope = { enabled = true }, -- highlight current scope
		},

		-- -----------------------------------------------------------------------
		-- input
		-- Prettier vim.ui.input() — replaces the ugly command-line prompt
		-- for rename, search/replace confirmations, etc.
		-- -----------------------------------------------------------------------
		input = { enabled = true },

		-- -----------------------------------------------------------------------
		-- notifier
		-- Replaces vim.notify() with floating notifications.
		-- -----------------------------------------------------------------------
		notifier = {
			enabled = true,
			timeout = 3000, -- ms before notifications auto-dismiss
			-- style = "compact", -- "compact" | "fancy" | "minimal"
		},

		-- -----------------------------------------------------------------------
		-- picker
		-- Fuzzy finder — replaces telescope / fzf-lua for most tasks.
		-- Keymaps are in the `keys` section below.
		-- -----------------------------------------------------------------------
		picker = { enabled = true },

		-- -----------------------------------------------------------------------
		-- quickfile
		-- Renders files faster by skipping some processing on initial open.
		-- -----------------------------------------------------------------------
		quickfile = { enabled = true },

		-- -----------------------------------------------------------------------
		-- scope
		-- Detects code scope (function, block, etc.) for motions and indent guides.
		-- -----------------------------------------------------------------------
		scope = { enabled = true },

		-- -----------------------------------------------------------------------
		-- scroll
		-- Smooth scrolling. Set enabled = false if you find it distracting.
		-- -----------------------------------------------------------------------
		scroll = { enabled = true },

		-- -----------------------------------------------------------------------
		-- statuscolumn
		-- Better statuscolumn: line numbers, signs, folds all in one.
		-- -----------------------------------------------------------------------
		statuscolumn = { enabled = true },

		-- -----------------------------------------------------------------------
		-- words
		-- Highlights all occurrences of the word under the cursor.
		-- Navigate matches with [[ and ]] (see keys below).
		-- -----------------------------------------------------------------------
		words = { enabled = true },

		-- -----------------------------------------------------------------------
		-- lazygit
		-- Opens lazygit in a floating window, themed to your colorscheme.
		-- Requires: lazygit installed (brew install lazygit)
		-- -----------------------------------------------------------------------
		lazygit = { enabled = true },

		-- -----------------------------------------------------------------------
		-- terminal
		-- Floating terminal toggle. Useful alongside claudecode.nvim.
		-- -----------------------------------------------------------------------
		terminal = { enabled = true },

		-- -----------------------------------------------------------------------
		-- zen
		-- Distraction-free writing mode.
		-- -----------------------------------------------------------------------
		zen = { enabled = true },

		-- -----------------------------------------------------------------------
		-- dim
		-- Dims inactive code outside the current scope.
		-- -----------------------------------------------------------------------
		dim = { enabled = false }, -- enable if you want focus mode

		-- -----------------------------------------------------------------------
		-- gitbrowse
		-- Open current file/line on GitHub/GitLab in the browser.
		-- -----------------------------------------------------------------------
		gitbrowse = { enabled = true },

		-- -----------------------------------------------------------------------
		-- scratch
		-- Quick scratch buffer per filetype.
		-- -----------------------------------------------------------------------
		scratch = { enabled = true },
	},

	-- -------------------------------------------------------------------------
	-- Keymaps
	-- -------------------------------------------------------------------------
	keys = {

		-- Picker (fuzzy finder)
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart find files",
		},
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command history",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find files",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Git files",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find buffers",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help pages",
		},
		{
			"<leader>fk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>fd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},

		-- LSP pickers (replaces telescope LSP keymaps)
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto definition",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto type definition",
		},

		-- Git
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gb",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git browse (open in browser)",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git log",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git status",
		},

		-- Notifications
		{
			"<leader>n",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification history",
		},
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss notifications",
		},

		-- Explorer
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "File explorer",
		},

		-- Terminal
		{
			"<C-\\>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle terminal",
			mode = { "n", "t" },
		},

		-- Scratch buffer
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Scratch buffer",
		},

		-- Zen mode
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Zen mode",
		},

		-- Dim inactive scopes
		{
			"<leader>uD",
			function()
				Snacks.dim()
			end,
			desc = "Toggle dim",
		},

		-- Word navigation (uses snacks.words)
		{
			"[[",
			function()
				Snacks.words.jump(-1, true)
			end,
			desc = "Prev word occurrence",
		},
		{
			"]]",
			function()
				Snacks.words.jump(1, true)
			end,
			desc = "Next word occurrence",
		},
	},
}
