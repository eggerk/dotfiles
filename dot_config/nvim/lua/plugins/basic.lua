return {
  { "Chiel92/vim-autoformat" },
  { "ntpeters/vim-better-whitespace" },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  { "powerman/vim-plugin-AnsiEsc" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        {'nvim-lua/plenary.nvim'},
        {"nvim-telescope/telescope-ui-select.nvim"},
    },
    config = function()
        local actions = require('telescope.actions')
        require('telescope').setup{
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {
                        -- even more opts
                    }
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

        require("telescope").load_extension("ui-select")

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<c-p>', builtin.find_files, {})
        vim.keymap.set('n', '<c-g>', builtin.git_files, {})
        vim.keymap.set('n', '<c-s>', builtin.live_grep, {})
        vim.keymap.set('n', '<c-b>', builtin.buffers, {})
        vim.keymap.set('n', '<space>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<space>gb', builtin.git_branches, {})
        vim.keymap.set('n', '<space>gs', builtin.git_status, {})
        vim.keymap.set('n', '<space>to', builtin.oldfiles, {})
        vim.keymap.set('n', '<space>lr', builtin.lsp_references, {})
        vim.keymap.set('n', '<space>ls', builtin.lsp_document_symbols, {})
        vim.keymap.set('n', '<space>lS', builtin.lsp_workspace_symbols, {})
        vim.keymap.set('n', '<space>ld', builtin.diagnostics, {})
      end
  },

  { "lukas-reineke/indent-blankline.nvim" },
}
