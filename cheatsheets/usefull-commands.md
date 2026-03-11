# This is a set of useful command utilities for nvim

For debugging and showing command history, while using mini.ai plugins
the following nvim commands are of essential usefulness.

- lua MiniNotify.show_history()
- lua MiniMessages.show_history()

In Neovim, :setlocal is one of those quietly powerful commands that separates casual editing from true editor wizardry.

1. What :setlocal means

setlocal changes an option only for the current buffer or window, instead of globally.
Think of the three scopes in Neovim:

Command Scope Effect
:set global affects everything
:setlocal local affects only the current buffer/window
:setglobal global default sets default for future buffers

So:
:set number
turns on line numbers everywhere.
But:

:setlocal number
turns on line numbers only in the current window.
Open another file → it may not have line numbers.

⸻

2. Why it exists (the real power)

Different filetypes often need different behavior.
Examples:

Filetype Useful local settings
Markdown wrap text
Rust no wrapping
Makefile no expandtab
Code show line numbers

setlocal lets you tune the editor per file without breaking everything else.

⸻

3. Classic examples

Turn wrapping on only for this file
:setlocal wrap

Very common for:
• Markdown
• text notes
• commit messages

⸻

Change indentation only for this buffer

:setlocal tabstop=2
:setlocal shiftwidth=2

Useful when a project uses a different indentation style.

⸻

Disable spell checking only here
:setlocal nospell

⸻

Show relative numbers only here
:setlocal relativenumber

⸻

4. Where setlocal shines (Filetype configs)
   Often used inside filetype autocmds.
   Example in Lua config:
   ```lua
   vim.api.nvim_create_autocmd("FileType", {
   pattern = "markdown",
   callback = function()
   vim.opt_local.wrap = true
   vim.opt_local.spell = true
   end,
   })
   ```

Equivalent Vim command logic:
autocmd FileType markdown setlocal wrap spell

Now every Markdown file gets:
• wrapped text
• spell check

But Rust files stay untouched.

⸻

5. Window-local vs buffer-local

Some options are window-local, others buffer-local.

Example:

Option Scope
number window
wrap window
shiftwidth buffer
tabstop buffer

Meaning:

You can split windows and give them different views of the same file.
Example:

Left window:
:setlocal number
Right window:
:setlocal nonumber
Same file — different display.

⸻

6. Inspecting what is local
   To see the local value:
   :setlocal wrap?

or

:set wrap?

Neovim will show where the option is set.

⸻

7. The Lua equivalent (modern configs)
   In Lua configs:

vim.opt_local.wrap = true
vim.opt_local.shiftwidth = 4

opt_local is basically Lua’s version of setlocal.

⸻

8. A practical workflow trick
   When editing Markdown (something you likely do in Obsidian and Neovim):
   :setlocal wrap linebreak spell

This gives:
• word wrapping
• no broken words
• spell check

Suddenly Neovim feels like a writing studio instead of a code editor.

⸻

9. A small Neovim Jedi trick

You can toggle things quickly:
:setlocal invnumber
inv = invert.

So it flips:
number ↔ nonumber
Very handy.

⸻

💡 Rule of thumb
If a setting should only affect this file or this window, use:
:setlocal

If it should affect everything, use:

:set

⸻
