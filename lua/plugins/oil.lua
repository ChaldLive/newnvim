return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, for file icons
	opts = {
		default_file_explorer = true,
		columns = {
			"icon",
			--	"permissions",
			--	"size",
			"mtime",
		},
		buf_options = {
			buflisted = false,
			bufhidden = "hide",
		},
		win_options = {
			wrap = false,
			signcolumn = "no",
			cursorcolumn = false,
			foldcolumn = "0",
			spell = false,
			list = false,
			concealcursor = "nvic",
			conceallevel = 3,
		},
		delete_to_trash = true,
		skip_confirm_for_simple_edits = false,
		prompt_save_on_select_new_entry = true,
		cleanup_delay_ms = 2000,
		lsp_file_methods = {
			timeout_ms = 1000,
			autosave_changes = false,
		},
		view_options = {
			show_hidden = false,
			is_hidden_file = function(name, _)
				return vim.startswith(name, ".")
			end,
			is_always_hidden = function(name, _)
				return name == ".."
			end,
			natural_order = true,
		},
		float = {
			padding = 2,
			max_width = 100,
			max_height = 30,
			border = "rounded",
			win_options = {
				winblend = 0,
			},
		},
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<C-s>"] = "actions.select_vsplit",
			["<C-h>"] = "actions.select_split",
			["<C-t>"] = "actions.select_tab",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["<C-r>"] = "actions.refresh",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["gs"] = "actions.change_sort",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
		},
		use_default_keymaps = true,
	},
	config = function(_, opts)
		require("oil").setup(opts)

		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>of", require("oil").toggle_float, { desc = "Oil float" })
	end,
}
