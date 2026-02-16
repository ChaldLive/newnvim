--
🧠 mini.ai — Rust + Markdown Text Object Guide
A complete reference for your Neovim studio
---
📦 Overview
This document describes a custom mini.ai preset designed for:
Rust engineering
Markdown prose writing
It includes:
semantic text objects
operator examples
a muscle‑memory training routine
the installation snippet for your Neovim config
Use these objects with operators like:
d → delete
c → change
y → yank
v → visual select
Examples:
cis → change inside sentence
vaM → select around match arm
---
🦀 Rust Text Objects
🔸 Match Arm — `M`
Useful inside match expressions.
Action	Keys	Meaning
inside	iM	Select only the body of the match arm
around	aM	Select the whole arm (pattern => { ... })
---
🔸 Closure — `C`
For Rust closures like |x| { ... }.
Action	Keys	Meaning
inside	iC	Inside closure body
around	aC	Whole closure including pipes
---
🔸 Generics — `G`
For &lt;T&gt;, &lt;Result&lt;T, E&gt;&gt;, etc.
Action	Keys	Meaning
inside	iG	Inside <...>
around	aG	Whole generic block
---
🔸 Result Variants — `R`
For Ok(value) and Err(error).
Action	Keys	Meaning
inside	iR	Inside the parentheses
around	aR	Whole variant call
---
✍️ Markdown Text Objects
🔸 Paragraph — `p`
A block of prose separated by blank lines.
Action	Keys	Meaning
inside	ip	Select paragraph content
around	ap	Select paragraph including surrounding whitespace
---
🔸 Sentence — `s`
Ends with ., !, or ?.
Action	Keys	Meaning
inside	is	Select sentence content
around	as	Select sentence including punctuation
---
🔸 Link — `l`
Markdown links like [text](url).
Action	Keys	Meaning
inside	il	Select link text only
around	al	Select full [text](url)
---
🔸 Emphasis — `*` or `_`
For *italic*, **bold**, _italic_.
Action	Keys	Meaning
inside	i*	Inside emphasis
around	a*	Whole emphasized region
---
🔸 Inline Code — ```
For code spans like `let x = 5`.
Action	Keys	Meaning
inside	i`	Inside backticks
around	a`	Whole code span
---
🧩 Operator Examples
Rust
ciM → change inside match arm
daC → delete whole closure
yiG → yank inside generics
vaR → visually select Ok(value)
Markdown
cis → change inside sentence
dap → delete paragraph
vil → visually select link text
ci` → change inline code
---
🏋️ Muscle Memory Training Routine
Use this for 5 minutes a day.
Rust
Navigate to a match arm → iM, aM
Navigate to a closure → iC, aC
Navigate to generics → iG, aG
Yank inside a Result → yiR
Markdown
Move through sentences → is, as
Edit paragraphs → cip, dap
Manipulate links → il, al
Change inline code → ci`
---
🧩 Installation Snippet (Neovim)
return {
  "echasnovski/mini.ai",
  event = "VeryLazy",
  config = function()
    local ai = require("mini.ai")

    ai.setup({
      custom_textobjects = {
        -- Markdown paragraph
        p = ai.gen_spec.treesitter({ a = "@paragraph.outer", i = "@paragraph.inner" }),

        -- Markdown sentence
        s = function()
          local text = vim.api.nvim_get_current_line()
          local col = vim.fn.col(".")
          local start = text:sub(1, col):find("[%.%!%?]%s*[^%.%!%?]*$")
          local finish = text:find("[%.%!%?]", col)
          if not start or not finish then return nil end
          return { from = { vim.fn.line("."), start }, to = { vim.fn.line("."), finish } }
        end,

        -- Markdown link
        l = { "%b[]%b()", "^%[().-()%]%b()" },

        -- Rust match arm
        M = { "^[%s%w_]+%s*=>%s*%b{}", "=>%s*%b{}" },

        -- Rust closure
        C = { "%b||%s*%b{}", "^|().-|()%s*%b{}" },

        -- Rust generics
        G = { "%b<>", "^<().-()>" },

        -- Rust Ok(..) / Err(..)
        R = { "Ok%b()", "Err%b()" },
      },
    })
  end,
}

---
If you want, I can also generate a matching Markdown document for your writing module (spelling picker, synonym picker, keymaps, workflow).
