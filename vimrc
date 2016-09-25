" load plugins from vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let vundle manage vundle
Plugin 'gmarik/vundle'

" utilities
Plugin 'scrooloose/nerdtree' " file drawer, open with :NERDTreeToggle
Plugin 'tpope/vim-fugitive' " the ultimate git helper
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-commentary' " comment/uncomment lines with gcc or gc in visual mode
Plugin 'taketwo/vim-ros'
Plugin 'airblade/vim-gitgutter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'
Plugin 'bkad/CamelCaseMotion'
Plugin 'lervag/vimtex'
Plugin 'tpope/vim-obsession'

call vundle#end()
filetype plugin indent on

set t_Co=256
set nocompatible " not compatible with vi
set autoread " detect when a file is changed

" make backspace behave in a sane manner
set backspace=indent,eol,start

" set a map leader for more key combos
let mapleader = ','

set clipboard=unnamedplus

" minimal number of of screen lines (context) above and below the cursor
:set scrolloff=5

" enable line numbers
:set ruler
:set number
:set relativenumber
:set showcmd

" set tab == 2 spaces
:set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab

"Enable code folding
set foldenable

" fold everything that is more than 1 level indented
set foldmethod=syntax
set foldnestmax=2
set foldlevel=1

" line at 80 chars
set colorcolumn=81
" highlight ColorColumn ctermbg=7
highlight ColorColumn ctermbg=magenta
au BufNewFile,BufRead *.tex setlocal colorcolumn=

" enable clang format
map <C-F> :pyf /usr/share/vim/addons/syntax/clang-format-3.4.py<cr>
imap <C-F> <c-o>:pyf /usr/share/vim/addons/syntax/clang-format-3.4.py<cr>

" use ctrl-hjkl to switch split
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" open new splits bottom/right
set splitbelow
set splitright

set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
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

set laststatus=2 " show the satus line all the time
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
set mouse=a

" let g:molokai_original = 1
" let g:rehash256 = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=1
" show hidden files in NERDTree
let NERDTreeShowHidden=1
" Toggle NERDTree
nmap <silent> <leader>k :NERDTreeToggle<cr>
" expand to the path of the file in the current buffer
nmap <silent> <leader>y :NERDTreeFind<cr>

" map fuzzyfinder (CtrlP) plugin
" nmap <silent> <leader>t :CtrlP<cr>
" nmap <silent> <leader>r :CtrlPBuffer<cr>
" let g:ctrlp_map='<leader>o'
" let g:ctrlp_dotfiles=1
" let g:ctrlp_working_path_mode = 'ra'

" CtrlP ignore patterns
" let g:ctrlp_custom_ignore = {
"             \ 'dir': '\.git$\|node_modules$\|\.hg$\|\.svn$',
"             \ 'file': '\.exe$\|\.so$'
"             \ }

" search the nearest ancestor that contains .git, .hg, .svn
" let g:ctrlp_working_path_mode = 2

let g:airline_powerline_fonts = 1
" let g:airline_theme = 'molokai'
" :Tmuxline airline

" GitGutter
set updatetime=500

let g:ycm_global_ycm_extra_conf = '/home/eggerk/.dotfiles/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
map <leader>g :YcmCompleter GoTo<cr>
map <leader>x :YcmCompleter GoToDefinition<cr>
map <leader>c :YcmCompleter GoToDeclaration<cr>
map <leader>t :YcmCompleter GetType<cr>
map <leader>i :YcmCompleter GoToInclude<cr>
" let g:ycm_semantic_triggers = {
" \  'tex'  : ['\ref{','\cite{'],
" \ }
" highlight YcmErrorSection guibg=#ff0000 guifg=#000000

nmap <leader>s :call VimuxRunCommand("git status")<cr>

" Camel case motion
map <silent> <leader>w <Plug>CamelCaseMotion_w
map <silent> <leader>b <Plug>CamelCaseMotion_b
map <silent> <leader>e <Plug>CamelCaseMotion_e
map <silent> <leader>ge <Plug>CamelCaseMotion_ge
" sunmap w
" sunmap b
" sunmap e
" sunmap ge

" Latex
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
" filetype plugin on

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
" set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
" filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
" let g:tex_flavor='latex'
