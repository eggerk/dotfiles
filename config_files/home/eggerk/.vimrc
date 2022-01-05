" load plugins from vundle
set nocompatible
filetype off

call plug#begin()
" General
Plug 'Chiel92/vim-autoformat'
Plug 'liuchengxu/vista.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'vim-scripts/Vimball'
Plug 'powerman/vim-plugin-AnsiEsc'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'RRethy/vim-illuminate'
Plug 'https://gitlab.com/yorickpeterse/nvim-dd.git'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'

" Theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" C++
Plug 'drmikehenry/vim-headerguard', { 'for': ['cpp', 'c'] }
Plug 'richq/vim-cmake-completion'
" Plug 'taketwo/vim-ros'

" Latex
Plug 'lervag/vimtex', { 'for': ['tex'] }

" CSV
Plug 'chrisbra/csv.vim', { 'for': ['csv'] }
call plug#end()

set autoread " Detect when a file is changed
set clipboard=unnamedplus

" Minimal number of of screen lines (context) above and below the cursor
set scrolloff=5

" Enable line numbers
set ruler
set number
set relativenumber
set showcmd

" No indentation after namespace.
set cino=N-s

" Use ctrl-hjkl to switch split
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
inoremap <C-J> <Esc><C-W><C-J>
inoremap <C-K> <Esc><C-W><C-K>
inoremap <C-L> <Esc><C-W><C-L>
inoremap <C-H> <Esc><C-W><C-H>

" Open new splits bottom/right
set splitbelow
set splitright
set equalalways

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set hlsearch
set incsearch " set incremental search, like modern browsers

" switch syntax highlighting on
syntax on

set autoindent " automatically set indent of new line
set smartindent

" set tab == 2 spaces
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
set smarttab

set laststatus=2 " show the satus line all the time
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=3
set mouse=a

set termguicolors
set cursorline
hi CursorLine cterm=none ctermbg=237 guibg=#eee8d5
highlight ColorColumn guibg=#eee8d5
set guifont=Ubuntu\ Mono\ derivative\ Powerline:h12
" au VimEnter * :highlight Todo ctermfg=lightgray ctermbg=darkblue

set colorcolumn=81  " Line at 80 chars.
autocmd FileType python setlocal colorcolumn=101
autocmd FileType rust setlocal colorcolumn=100
" highlight Search ctermfg=white
au BufNewFile,BufRead *.tex setlocal colorcolumn=

" " Disable relativenumber and cursorline for Latex files.
" au BufNewFile,BufRead *.tex
"     \ setlocal nocursorline |
"     \ setlocal nornu |
"     \ setlocal number |

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Format
noremap <C-F> V:Autoformat<cr>
imap <C-F> <c-o>V:Autoformat<cr>
let g:formatdef_clangformat='"clang-format-11 -style=file -fallback-style=google"'
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:formatters_python=['yapf']
let g:formatdef_yapf = '"yapf --style /usr/share/sevensense_linter/yapf_style_100_column_length.cfg"'

let g:airline_powerline_fonts = 1
" let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
" let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
let g:airline_theme='solarized'

" GitGutter
set updatetime=500

"" Highlight symbol under cursor on CursorHold
"hi default CocHighlightText ctermbg=magenta guibg=#61AFEF guifg=white
"hi default CocRustTypeHint guifg=#b5b5b5 gui=italic
"hi default CocRustChainingHint guifg=#b5b5b5 gui=italic

set completeopt=menu,menuone,noselect,noinsert,preview

luafile ~/dotfiles/neovim/lsp.lua

" Avoid showing message extra message when using completion
set shortmess+=c

" Telescope
luafile ~/dotfiles/neovim/telescope_settings.lua

" Commentary
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
autocmd FileType cmake setlocal commentstring=#\ %s

" HeaderGuards
function! g:HeaderguardName()
  let project_name = expand('%:p:gs@.*include/\(.*\)/.*@\1@g')
  let project_name = substitute(project_name, '[^0-9a-zA-Z_]', '_', 'g')
  let project_name = toupper(project_name)
  let file_name = toupper(expand('%:t:gs/[^0-9a-zA-Z_]/_/g'))
  return project_name . "_" . file_name . "_"
endfunction

function! g:HeaderguardLine3()
  return "#endif  // " . g:HeaderguardName() . ""
endfunction

" Vim-ros
let g:ros_build_system="catkin-tools"

command! CatkinBuildThis execute ":sp term://cd $(dirname %) && catkin build --this --no-deps"
command! CatkinBuildFromThis execute ":sp term://cd $(dirname %) && catkin build --start-with-this"
command! CatkinBuildAll execute ":sp term://cd $(dirname %) && catkin build --this"
command! CatkinTestThis execute ":sp term://cd $(dirname %) && catkin run_tests --this --no-deps"
command! -nargs=+ CatkinBuild execute ":sp term://cd $(dirname %) && catkin build --no-deps " . <f-args>
command! -nargs=+ CatkinBuildWithDeps execute ":sp term://cd $(dirname %) && catkin build " . <f-args>
nmap <leader>bt :CatkinBuildThis<CR>
nmap <leader>ba :CatkinBuildAll<CR>
nmap <leader>tt :CatkinTestThis<CR>

" Vista
let g:vista_default_executive = 'coc'

" Taken from https://vim.fandom.com/wiki/Modeline_magic
" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
