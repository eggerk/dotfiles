local cspell_config = {
  ---@param payload AddToJSONSuccess
  on_add_to_json = function(payload)
      -- For example, you can format the cspell config file after you add a word
      os.execute(
          string.format(
              "jq --indent 4 -S '.words |= sort_by(ascii_upcase)' %s > %s.tmp && mv %s.tmp %s",
              payload.cspell_config_path,
              payload.cspell_config_path,
              payload.cspell_config_path,
              payload.cspell_config_path
          )
      )
  end
}

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "williamboman/mason.nvim",
            },
            {
                "williamboman/mason-lspconfig.nvim",
            },
        },
        -- config = function()
            -- luafile ~/.config/nvim/lua/lsp_config.lua
        -- end
    },
    {
        "chrisgrieser/nvim-lsp-endhints",
        event = "LspAttach",
        opts = {
            label = {
                padding = 1,
                marginLeft = 3,
                bracketedParameters = true,
            },
            autoEnableHints = true,
        },
    },
    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        dependencies = {
            "davidmh/cspell.nvim",
            "nvim-lua/plenary.nvim"
        },
        opts = function(_, opts)
          local cspell = require("cspell")
          opts.sources = opts.sources or {}
          table.insert(
              opts.sources,
              cspell.diagnostics.with({
                  config = cspell_config,
                  diagnostics_postprocess = function(diagnostic)
                      diagnostic.severity = vim.diagnostic.severity.HINT
                  end,
              })
          )
          table.insert(
              opts.sources,
              cspell.code_actions.with({config = cspell_config})
          )
        end,
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        lazy = false, -- This plugin is already lazy
    },
    {
      "ray-x/lsp_signature.nvim",
      event = "InsertEnter",
      opts = {
        -- cfg options
      },
    },
    { "RRethy/vim-illuminate" },
    { "yorickpeterse/nvim-dd" },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            cmp = require("cmp")
            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
                    end,
                },
                mapping = {
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),

                    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
                    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' }, -- For vsnip users.
                    { name = 'buffer' },
                    { name = 'path' },
                }
            })
        end
    },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/vim-vsnip" },
}
