-- Leaders FIRST
-- keymap.lua
local map = vim.keymap.set

map("n", "<leader>e", function()
	require("mini.files").open()
end, { desc = "Open mini.files" })

map("n", "<leader>q", ":q<CR>")
map("n", "<leader>w", ":w<CR>")

-- Telescope keybindings
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })

-- LSP
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- Basic quality of life
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>q", ":q<CR>")
-- Basic mini.Notify show your history
map("n", "<leader>nh", function()
	MiniNotify.show_history()
end, { desc = "Notification History" })

-- Mini.pick: file picker

vim.schedule(function()
	require("mini.pick") -- ensures plugin is loaded
	map("n", "<leader>pf", function()
		MiniPick.builtin.files()
	end, { desc = "find files" })

	map("n", "<leader>pg", function()
		MiniPick.builtin.grep_live()
	end, { desc = "Live Grep" })

	map("n", "<leader>pb", function()
		MiniPick.builtin.buffers()
	end, { desc = "Pick Buffers" })

	map("n", "<leader>pr", function()
		MiniPick.builtin.recent()
	end, { desc = "Recent Files" })
end)

-- Horizontal split
map("n", "<leader>ph", function()
	vim.cmd("split")
	vim.cmd("wincmd j")
end, { desc = "Horizontal split and move cursor" })

-- Vertical split
map("n", "<leader>pv", function()
	vim.cmd("vsplit")
	vim.cmd("wincmd l")
end, { desc = "Vertical split and move cursor" })

-- Some extra stuff for linters and formating my code

map("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })
