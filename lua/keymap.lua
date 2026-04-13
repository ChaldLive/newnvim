-- ============================================
-- Keymap.lua — clean, sharp, editing‑focused
-- ============================================

local map = vim.keymap.set

-- ============================================
-- 1. Leader and basic actions
-- ============================================

map("n", "<leader>w", ":w<CR>", { desc = "Write buffer" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit window" })
map("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle Undotree" })
map("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open Oil" })

-- If you choose Neo-tree or Oil, we’ll add mappings here later.
-- For now, <leader>e is intentionally left unused.

-- ============================================
-- 2. Telescope (your main picker)
-- ============================================

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })

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

		-- Glow preview
		map("n", "<leader>mp", ":Glow<CR>", opts)
	end,
})
