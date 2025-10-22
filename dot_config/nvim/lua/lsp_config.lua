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

vim.lsp.config('pyright', {
  on_attach = lsp_on_attach,
})
vim.lsp.enable('pyright')
vim.lsp.config('clangd', {
  on_attach = lsp_on_attach,
  cmd = {'clangd', '--background-index'},
})
vim.lsp.enable('clangd')

vim.lsp.config('bashls', { on_attach = lsp_on_attach })
vim.lsp.enable('bashls')
vim.lsp.config('jsonls', { on_attach = lsp_on_attach })
vim.lsp.enable('jsonls')
vim.lsp.config('yamlls', { on_attach = lsp_on_attach })
vim.lsp.enable('yamlls')

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
