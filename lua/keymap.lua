-- ============================================
-- 1. Leader and basic settings
-- ============================================
local map = vim.keymap.set

map("n", "<leader>e", function()
	require("mini.files").open()
end, { desc = "Open mini.files" })

map("n", "<leader>w", ":w<CR>", { desc = "Write buffer" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit window" })

-- Notification history
map("n", "<leader>nh", function()
	MiniNotify.show_history()
end, { desc = "Notification History" })

-- ============================================
-- 2. Telescope / Mini.pick
-- ============================================

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })

-- Mini.pick (loaded async)
vim.schedule(function()
	require("mini.pick")

	map("n", "<leader>pf", function()
		MiniPick.builtin.files()
	end, { desc = "Pick files" })

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

-- ============================================
-- 3. LSP
-- ============================================

map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- ============================================
-- 4. Window management
-- ============================================

map("n", "<leader>ph", function()
	vim.cmd("split")
	vim.cmd("wincmd j")
end, { desc = "Horizontal split and move cursor" })

map("n", "<leader>pv", function()
	vim.cmd("vsplit")
	vim.cmd("wincmd l")
end, { desc = "Vertical split and move cursor" })

-- ============================================
-- 5. Formatting
-- ============================================

map("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- ============================================
-- 6. Filetype-specific mappings
-- ============================================

-- Markdown mappings (your prose + documentation workflow)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		local opts = { buffer = true, silent = true }

		-- Paragraph navigation
		map("n", "]p", "}", opts)
		map("n", "[p", "{", opts)

		-- Sentence navigation
		map("n", "]s", function()
			vim.fn.search("[.!?]\\s", "W")
		end, opts)
		map("n", "[s", function()
			vim.fn.search("[.!?]\\s", "bW")
		end, opts)

		-- Link helpers
		map("n", "gil", "vil", opts)
		map("n", "gal", "val", opts)

		-- Inline code helpers
		map("n", "gi`", "vi`", opts)
		map("n", "ga`", "va`", opts)

		-- Emphasis helpers
		map("n", "gi*", "vi*", opts)
		map("n", "ga*", "va*", opts)

		-- Glow preview (manual, as you prefer)
		map("n", "<leader>mp", ":Glow<CR>", opts)
	end,
})
