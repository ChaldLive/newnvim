-- ~/.config/nvim/lua/plugins/nvim-yazi.lua

return {
  {
    "mikavilpas/yazi.nvim",
    name = "yazi.nvim", -- force correct plugin identity
    commit = "160c105", -- pinned: versions after this require Neovim 0.11 (winborder)
    event = "VeryLazy",

    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },

    keys = {
      {
        "<leader>e",
        "<cmd>Yazi<cr>",
        mode = { "n", "v" },
        desc = "Open yazi (current file)",
      },
      {
        "<leader>E",
        "<cmd>Yazi cwd<cr>",
        desc = "Open yazi (cwd)",
      },
      {
        "<leader>ye",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume last yazi session",
      },
    },

    opts = {
      open_for_directories = true,

      ui = {
        border = "rounded",
        winblend = 0,
        scaling_factor = 0.90,
      },

      keymaps = {
        show_help = "<f1>",
        open_file_in_vertical_split = "<c-v>",
        open_file_in_horizontal_split = "<c-x>",
        open_file_in_tab = "<c-t>",
        grep_in_directory = "<c-s>",
        cycle_open_buffers = "<tab>",
        copy_relative_path_to_selected_files = "<c-y>",
        send_to_quickfix_list = "<c-q>",
        change_working_directory = "<c-\\>",
        open_and_pick_window = "<c-o>",
      },
    },

    init = function()
      vim.g.loaded_netrwPlugin = 1
    end,
  },
}
