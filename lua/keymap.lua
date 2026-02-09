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
