return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,

        config = function ()
            local configs = require("nvim-treesitter.configs")
            -- A list of parser names, or "all" (the five listed parsers should always be installed)
            configs.setup({
                ensure_installed = { "c", "lua", "vim", "rust", "python", "cpp", "bash" },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
                -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

                highlight = {
                    enable = true,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },

                indent = {
                    enable = true
                },

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<leader>vi", -- set to `false` to disable one of the mappings
                        node_incremental = "<leader>vn",
                        scope_incremental = "<leader>vs",
                        node_decremental = "<leader>vp",
                    },
                },

                -- rainbow = {
                    --   enable = true,
                    --   -- list of languages you want to disable the plugin for
                    --   disable = {},
                    --   -- Which query to use for finding delimiters
                    --   query = 'rainbow-parens',
                    --   -- Highlight the entire buffer all at once
                    --   strategy = require('ts-rainbow').strategy.global,
                    -- }
                })
        end,
        build = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
        end,
    },
    { "HiPhish/nvim-ts-rainbow2" }
}
