-- ~/.config/nvim/lua/plugins/claudecode.lua
-- Claude Code Neovim integration via claudecode.nvim
-- Requires: Claude Code CLI installed (https://docs.anthropic.com/en/docs/claude-code)
-- Requires: folke/snacks.nvim (terminal provider)

return {
	"coder/claudecode.nvim",

	dependencies = {
		"folke/snacks.nvim", -- Used as the terminal provider
	},

	-- Lazy-load: only spin up when these commands or keys are triggered
	cmd = {
		"ClaudeCode",
		"ClaudeCodeFocus",
		"ClaudeCodeSend",
		"ClaudeCodeAdd",
		"ClaudeCodeTreeAdd",
		"ClaudeCodeDiffAccept",
		"ClaudeCodeDiffDeny",
		"ClaudeCodeSelectModel",
	},

	keys = {
		-- Namespace all Claude bindings under <leader>a (mnemonic: AI)
		{ "<leader>a", nil, desc = "AI / Claude Code" },

		-- Toggle the Claude panel open/closed
		{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },

		-- Smart focus: jumps to Claude if open, hides if already focused
		{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },

		-- Resume a previous session (opens the interactive session picker)
		{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume session" },

		-- Continue the most recent session (no picker, instant)
		{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue last session" },

		-- Add the current buffer to Claude's context
		{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },

		-- Send visual selection as context to Claude
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection" },

		-- Add file from tree explorers (works in nvim-tree, neo-tree, oil, mini.files)
		{
			"<leader>at",
			"<cmd>ClaudeCodeTreeAdd<cr>",
			desc = "Add file from tree",
			ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
		},

		-- Diff management: accept or reject Claude's proposed changes
		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },

		-- Switch model mid-session
		{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select model" },
	},

	opts = {
		-- -----------------------------------------------------------------------
		-- Server
		-- -----------------------------------------------------------------------
		auto_start = true, -- Start WebSocket server when Neovim opens
		log_level = "warn", -- "trace" | "debug" | "info" | "warn" | "error"

		-- If you used `claude migrate-installer` or the native binary installer,
		-- uncomment and set the path reported by `which claude`:
		-- terminal_cmd = "~/.claude/local/claude",

		-- -----------------------------------------------------------------------
		-- Selection tracking
		-- -----------------------------------------------------------------------
		track_selection = true, -- Send cursor context to Claude in real-time
		visual_demotion_delay_ms = 50, -- Debounce before normal mode loses visual context

		-- -----------------------------------------------------------------------
		-- Terminal panel
		-- -----------------------------------------------------------------------
		terminal = {
			provider = "snacks", -- "auto" | "snacks" | "native" | "external" | "none"
			split_side = "right", -- snacks supports "left" | "right" | "top" | "bottom"
			split_width_percentage = 0.35, -- 35% of editor width
			auto_close = true, -- Close panel when Claude exits
			snacks_win_opts = { width = 0.35 }, -- 35% of editor width

			-- Working directory: always anchor to the git repo root.
			-- Remove this block if you prefer the default cwd behaviour.
			cwd_provider = function(ctx)
				local root = require("claudecode.cwd").git_root(ctx.file_dir or ctx.cwd)
				return root or ctx.file_dir or ctx.cwd
			end,
		},

		-- -----------------------------------------------------------------------
		-- Diff view
		-- -----------------------------------------------------------------------
		diff_opts = {
			auto_close_on_accept = true, -- Close diff buffer after accepting
			vertical_split = true, -- Side-by-side diff (false = horizontal)
			open_in_current_tab = true, -- Keep diff in current tab
			keep_terminal_focus = false, -- Move focus to diff, not back to terminal
		},

		-- -----------------------------------------------------------------------
		-- Send / Focus behaviour
		-- -----------------------------------------------------------------------
		focus_after_send = false, -- Don't auto-jump to Claude panel after sending context
	},

	-- config = true tells lazy to call require("claudecode").setup(opts) for us.
	-- Only replace this with a function if you need custom setup logic.
	config = true,
}
