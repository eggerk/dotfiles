return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Theme
  use "shaunsingh/solarized.nvim"
  use "vim-airline/vim-airline"
  use "vim-airline/vim-airline-themes"


  -- General
  use "Chiel92/vim-autoformat"
  use "liuchengxu/vista.vim"
  use "ntpeters/vim-better-whitespace"
  use "tpope/vim-commentary"
  use "tpope/vim-obsession"
  use "vim-scripts/Vimball"
  use "powerman/vim-plugin-AnsiEsc"

  use "nvim-lua/plenary.nvim"
  use "nvim-telescope/telescope.nvim"
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }
  use "nvim-telescope/telescope-ui-select.nvim"

  -- LSP
  use "neovim/nvim-lspconfig"
  use "simrat39/rust-tools.nvim"
  use "ray-x/lsp_signature.nvim"
  use "RRethy/vim-illuminate"
  use "https://gitlab.com/yorickpeterse/nvim-dd.git"

  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-path"

  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"
  use "rafamadriz/friendly-snippets"

  -- Git
  use "airblade/vim-gitgutter"
  use "tpope/vim-fugitive"

  -- C++
  use { "drmikehenry/vim-headerguard", ft = {'cpp', 'c'} }
  use "richq/vim-cmake-completion"
  -- use 'taketwo/vim-ros'

  -- Latex
  -- "lervag/vimtex', { 'for': ['tex",] }

  -- CSV
  -- "chrisbra/csv.vim', { 'for': ['csv",] }
end)
