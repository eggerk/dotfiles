local nvim_lsp = require('lspconfig')

local cmp = require'cmp'
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

require "lsp_signature".on_attach({
  bind = true,
  handler_opts = {
    border = "none"
  }
})

local lsp_on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

  require 'illuminate'.on_attach(client)

  vim.api.nvim_command [[ hi def link LspReferenceText CursorLine ]]
  vim.api.nvim_command [[ hi def link LspReferenceWrite CursorLine ]]
  vim.api.nvim_command [[ hi def link LspReferenceRead CursorLine ]]

  vim.api.nvim_set_keymap('n', ']r', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
  vim.api.nvim_set_keymap('n', '[r', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})
end

require('cmp_nvim_lsp').default_capabilities()

nvim_lsp.typos_lsp.setup{}

nvim_lsp.pyright.setup {
  on_attach = lsp_on_attach,
}
nvim_lsp.clangd.setup {
  on_attach = lsp_on_attach,
  cmd = {'clangd', '--background-index'},
}

nvim_lsp.bashls.setup { on_attach = lsp_on_attach }
nvim_lsp.jsonls.setup { on_attach = lsp_on_attach }
nvim_lsp.yamlls.setup { on_attach = lsp_on_attach }

local rust_lsp_on_attach = function(client, bufnr)
  lsp_on_attach(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', '<space>k', "<cmd>lua vim.cmd.RustLsp('openDocs')<CR>", opts)
  buf_set_keymap('n', '<space>p', "<cmd>lua vim.cmd.RustLsp('openCargo')<CR>", opts)
end

vim.g.rustaceanvim = function()
  return {
    -- Plugin configuration
    tools = {
    },
    -- LSP configuration
    server = {
      on_attach = rust_lsp_on_attach,
      default_settinigs = {
        -- rust-analyzer language server configuration
        ['rust-analyzer'] = {
        },
      },
    },
    -- DAP configuration
    dap = {
    },
  }
end

require('dd').setup()

require("mason").setup()
require("mason-lspconfig").setup()
require("lsp-endhints").setup {
	icons = {
		type = "▸ ",
		parameter = "◂ ",
	},
	label = {
		padding = 1,
		marginLeft = 3,
		bracketedParameters = true,
	},
	autoEnableHints = true,
}


local cspell = require('cspell')
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

local null_ls = require("null-ls")
null_ls.setup {
    sources = {
        cspell.diagnostics.with({ config = cspell_config }),
        cspell.code_actions.with({ config = cspell_config }),
    }
}
