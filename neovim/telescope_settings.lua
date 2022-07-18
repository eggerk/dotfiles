local actions = require('telescope.actions')
require('telescope').setup{
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  },
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-j>"] = actions.move_selection_next,
      },
    },
  }
}

require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")

vim.api.nvim_set_keymap('n', '<c-p>', [[<Cmd>lua require('telescope.builtin').find_files()<cr>]], {})
vim.api.nvim_set_keymap('n', '<c-p>', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], {})
vim.api.nvim_set_keymap('n', '<c-g>', [[<cmd>lua require('telescope.builtin').git_files()<cr>]], {})
vim.api.nvim_set_keymap('n', '<c-s>', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], {})
vim.api.nvim_set_keymap('n', '<c-b>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], {})
vim.api.nvim_set_keymap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], {})
vim.api.nvim_set_keymap('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], {})
