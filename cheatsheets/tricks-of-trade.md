Ah, excellent. setlocal is where Neovim quietly turns from a text editor into a precision instrument. Here are some practical tricks that experienced users lean on all the time.

⸻

## 10 practical setlocal tricks in Neovim

1. Turn Markdown into a writing environment

When editing Markdown:

:setlocal wrap
:setlocal linebreak
:setlocal spell

Result:
• text wraps naturally
• words are not broken
• spell checking is active

Your buffer suddenly behaves more like a writing studio than a code editor.

A common combo:

:setlocal wrap linebreak spell

⸻

2. Enable relative numbers only where navigation matters
   Relative numbers make jumping around code very fast.
   :setlocal relativenumber

Move 10 lines down:
10j
But you may not want them in prose documents.
So in Markdown:
:setlocal norelativenumber

⸻

3. Disable automatic comment continuation

Neovim loves to continue comments automatically.
Sometimes it gets annoying.
Example:

-- comment
-- new line starts with --

Disable it locally:
:setlocal formatoptions-=cro

This stops automatic comment leaders.
Many Neovim users add this to all files.

⸻

4. Change indentation per project
   If you open a file that uses 2 spaces instead of 4:

:setlocal tabstop=2
:setlocal shiftwidth=2
:setlocal expandtab

Or as one line:

:setlocal ts=2 sw=2 et
Now indentation behaves correctly only in this buffer.

⸻

5. Enable spell check only for comments
   Useful for programming:
   :setlocal spell spelllang=en
   Then add this:
   :setlocal spellcapcheck=
   Now your comments and strings can be spell-checked without affecting code logic.

⸻

6. Highlight long lines (great for coding standards)
   If a project wants lines under 80 characters:
   :setlocal colorcolumn=80
   Or multiple:
   :setlocal colorcolumn=80,100
   Very helpful when writing:
   • Rust
   • C++
   • Python

⸻

7. Treat Markdown lists nicely
   For better formatting:
   :setlocal formatoptions+=n
   This lets list items wrap properly:

- long bullet text that wraps
  correctly aligned

Great for note-taking in Markdown.

⸻

8. Make search highlight temporary
   Sometimes highlight gets distracting.
   Turn it off locally:
   :setlocal nohlsearch

Search still works — the highlight disappears.

⸻

9. Different views of the same file

Because some settings are window-local, you can do this:
Split window:
:split
Left side:
:setlocal wrap
Right side:
:setlocal nowrap

Same file, two perspectives.

Very useful for:
• editing long text
• inspecting long code lines.

⸻

10. Toggle options instantly

Use inv:

:setlocal invnumber

This flips:

number ↔ nonumber

Same for:

:setlocal invlist
:setlocal invwrap
:setlocal invspell

Instant toggles.

⸻

A small luxury mapping many power users create

Add a toggle wrap shortcut:

vim.keymap.set("n", "<leader>w", function()
vim.opt_local.wrap = not vim.opt_local.wrap:get()
end)

Press:

<leader>w

and wrapping flips on/off.

⸻

A bonus trick many people miss

You can reset a local option to global default:

:setlocal shiftwidth<

The < means:

“use the global value again”.

⸻

One mental model that helps

Think of Neovim settings like this:

global settings → your normal editor
setlocal → special behavior for this file

It is like putting temporary lenses on a buffer.

⸻

Since you enjoy pushing Neovim further (and you are already tinkering with plugins and Lua configs), the next level trick is something many users never discover:
buffer-local keymaps and commands using setlocal logic.
They let Markdown, Rust, Lua, etc. have completely different keyboard behaviors.
If you’re interested, I can show a few of those — they feel almost like giving each filetype its own mini-editor. 😄
