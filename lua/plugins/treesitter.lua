
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      local ok, tsconfig = pcall(require, "nvim-treesitter.config")
      if not ok then
        vim.notify("nvim-treesitter.config not found", vim.log.levels.ERROR)
        return
      end

      tsconfig.setup({

        -- Install the languages you actually use
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "bash",
          "markdown",
          "markdown_inline",

          -- Your coding stack
          "rust",
          "python",
          "javascript",
          "typescript",
          "tsx",
          "html",
          "css",
          "json",
          "toml",
          "yaml",
          "java",
          "c_sharp",
        },

        -- Enable syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        -- Enable indentation
        indent = {
          enable = true,
        },

        -- Incremental selection (very useful)
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<BS>",
          },
        },

        -- Textobjects (if you want them)
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
          },
        },

      })
    end,
  },
}
