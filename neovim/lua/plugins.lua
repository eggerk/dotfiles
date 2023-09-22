return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Theme
  use "shaunsingh/solarized.nvim"
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- General
  use "Chiel92/vim-autoformat"
  use "ntpeters/vim-better-whitespace"
  -- use "tpope/vim-commentary"
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use "powerman/vim-plugin-AnsiEsc"

  use {
    "nvim-telescope/telescope.nvim",
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }
  use "nvim-telescope/telescope-ui-select.nvim"

  use "lukas-reineke/indent-blankline.nvim"

  -- LSP
  use "neovim/nvim-lspconfig"
  use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
  }
  use "simrat39/rust-tools.nvim"
  use "ray-x/lsp_signature.nvim"
  use "RRethy/vim-illuminate"
  use "yorickpeterse/nvim-dd" -- Defer diagnostics.

  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-path"

  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use "HiPhish/nvim-ts-rainbow2"

  -- Git
  use "tpope/vim-fugitive"
  use {
    'lewis6991/gitsigns.nvim',
  }

  -- Latex
  -- "lervag/vimtex', { 'for': ['tex",] }

  -- CSV
  -- "chrisbra/csv.vim', { 'for': ['csv",] }
end)
