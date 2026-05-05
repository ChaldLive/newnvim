-- writing.lua — prose enhancements (spelling + synonyms via vim.ui.select)

local M = {}

local function get_word_bounds()
  local _, col0 = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local col = col0 + 1
  local start_col = col
  while start_col > 1 and line:sub(start_col - 1, start_col - 1):match("[%w']") do
    start_col = start_col - 1
  end
  local end_col = col
  while end_col <= #line and line:sub(end_col, end_col):match("[%w']") do
    end_col = end_col + 1
  end
  return start_col, end_col - 1, line
end

local function replace_word_under_cursor(new_word)
  local start_col, end_col, line = get_word_bounds()
  vim.api.nvim_set_current_line(line:sub(1, start_col - 1) .. new_word .. line:sub(end_col + 1))
end

local function spelling_picker()
  vim.cmd("normal! ]s")
  local word = vim.fn.expand("<cword>")
  if word == "" then return end
  local suggestions = vim.fn.spellsuggest(word)
  if #suggestions == 0 then return end
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.ui.select(suggestions, { prompt = "Spelling: " .. word }, function(choice)
    if choice then
      vim.schedule(function()
        vim.api.nvim_win_set_cursor(0, pos)
        replace_word_under_cursor(choice)
      end)
    end
  end)
end

local function synonym_picker()
  local word = vim.fn.expand("<cword>")
  if word == "" then return end
  local json = vim.fn.system({ "curl", "-s", "https://api.datamuse.com/words?rel_syn=" .. word })
  if json == "" then return end
  local ok, results = pcall(vim.json.decode, json)
  if not ok or not results or #results == 0 then return end
  local synonyms = vim.tbl_map(function(item) return item.word end, results)
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.ui.select(synonyms, { prompt = "Synonyms: " .. word }, function(choice)
    if choice then
      vim.schedule(function()
        vim.api.nvim_win_set_cursor(0, pos)
        replace_word_under_cursor(choice)
      end)
    end
  end)
end

function M.setup()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "md", "text", "gitcommit" },
    callback = function()
      vim.keymap.set("n", "<leader>s", spelling_picker, { buffer = true, desc = "Spelling suggestions" })
      vim.keymap.set("n", "<leader>y", synonym_picker, { buffer = true, desc = "Synonym suggestions" })
      vim.opt_local.spell = true
      vim.opt_local.spelllang = "en"
    end,
  })
end

return M
