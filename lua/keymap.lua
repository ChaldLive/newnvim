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

-- LSP (hover/rename/code action — navigation lives in snacks picker keymaps)
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- ============================================
-- 3. Window management
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
-- 4. Formatting
-- ============================================

map("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })
-- ============================================
-- 5. Local buffer spelling lang
-- ============================================
map("n", "<leader>ld", function()
	vim.opt_local.spell = true
	vim.opt_local.spelllang = "da"
end, { desc = "Enable danish spell control" })

map("n", "<leader>le", function()
	vim.opt_local.spell = true
	vim.opt_local.spelllang = "en"
end, { desc = "Enable English spell control" })

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

		-- Marked preview
		map("n", "<leader>mp", ':!open -a "Marked 2" %<CR><CR>', opts)
	end,
})
