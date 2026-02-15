-- My own nice mini.ai config doing nice things in markdown, and rust programming
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
					if not start or not finish then
						return nil
					end
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
