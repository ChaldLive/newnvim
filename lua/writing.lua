-- writing.lua — Telescope-powered prose enhancements

local M = {}

----------------------------------------------------------------------
-- Word boundary detection (cursor-safe)
----------------------------------------------------------------------

local function get_word_bounds()
  local row, col0 = unpack(vim.api.nvim_win_get_cursor(0))
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
  end_col = end_col - 1

  return start_col, end_col, line
end

----------------------------------------------------------------------
-- Replace the word under cursor
----------------------------------------------------------------------

local function replace_word_under_cursor(new_word)
  local start_col, end_col, line = get_word_bounds()
  local before = line:sub(1, start_col - 1)
  local after  = line:sub(end_col + 1)
  vim.api.nvim_set_current_line(before .. new_word .. after)
end

----------------------------------------------------------------------
-- Telescope spelling picker
----------------------------------------------------------------------

local function spelling_picker()
  vim.cmd("normal! ]s")

  local word = vim.fn.expand("<cword>")
  if word == "" then return end

  local suggestions = vim.fn.spellsuggest(word)
  if #suggestions == 0 then return end

  local pos = vim.api.nvim_win_get_cursor(0)

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "Spelling suggestions",
    finder = finders.new_table(suggestions),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        vim.schedule(function()
          vim.api.nvim_win_set_cursor(0, pos)
          replace_word_under_cursor(selection[1])
        end)
      end)
      return true
    end,
  }):find()
end

----------------------------------------------------------------------
-- Telescope synonym picker
----------------------------------------------------------------------

local function synonym_picker()
  local word = vim.fn.expand("<cword>")
  if word == "" then return end

  -- Query Datamuse API for synonyms
  local url = "https://api.datamuse.com/words?rel_syn=" .. word
  local json = vim.fn.system({ "curl", "-s", url })
  if json == "" then return end

  local ok, results = pcall(vim.json.decode, json)
  if not ok or not results or #results == 0 then return end

  local synonyms = {}
  for _, item in ipairs(results) do
    table.insert(synonyms, item.word)
  end

  local pos = vim.api.nvim_win_get_cursor(0)

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "Synonyms for: " .. word,
    finder = finders.new_table(synonyms),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        vim.schedule(function()
          vim.api.nvim_win_set_cursor(0, pos)
          replace_word_under_cursor(selection[1])
        end)
      end)
      return true
    end,
  }):find()
end

----------------------------------------------------------------------
-- Setup
----------------------------------------------------------------------

function M.setup()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "md", "text", "gitcommit" },
    callback = function()
      vim.keymap.set("n", "<leader>s", spelling_picker, {
        buffer = true,
        desc = "Spelling suggestions",
      })

      vim.keymap.set("n", "<leader>y", synonym_picker, {
        buffer = true,
        desc = "Synonym suggestions",
      })

      vim.opt_local.spell = true
      vim.opt_local.spelllang = "en"
    end,
  })
end

return M

