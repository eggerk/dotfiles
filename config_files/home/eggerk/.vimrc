" load plugins from vundle
set nocompatible
filetype off

call plug#begin()
" General
Plug 'joshdick/onedark.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'yuki-ycino/fzf-preview.vim'
Plug 'liuchengxu/vista.vim'
" Plug 'Shougo/echodoc.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'vim-scripts/Vimball'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'bogado/file-line'

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
colorscheme onedark
set cursorline
hi CursorLine cterm=none ctermbg=237 guibg=#2C323C
set guifont=Ubuntu\ Mono\ derivative\ Powerline:h12

set colorcolumn=81  " Line at 80 chars.
highlight ColorColumn ctermbg=magenta
" highlight Search ctermfg=white
au BufNewFile,BufRead *.tex setlocal colorcolumn=
au VimEnter * :highlight Todo ctermfg=lightgray ctermbg=darkblue

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
let g:formatdef_clangformat='"clang-format -style=file -fallback-style=google"'
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:formatters_python=['yapf']
let g:formatter_yapf_style='pep8'

let g:airline_powerline_fonts = 1
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
let g:airline_theme='base16_default'

" GitGutter
set updatetime=500

"""""
" CoC
" if hidden not set, TextEdit might fail.
set hidden

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>cg <Plug>(coc-definition)
nmap <leader>cr <Plug>(coc-references)

nmap <leader>cd <Plug>(coc-diagnostic-info)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
hi default CocHighlightText ctermbg=magenta guibg=#61AFEF guifg=white
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>cn <Plug>(coc-rename)

" Fix autofix problem of current line
nmap <leader>cf  <Plug>(coc-fix-current)

" fzf
map <c-p> :FzfPreviewDirectoryFiles<cr>
map <c-g> :FzfPreviewProjectFiles<cr>
map <c-b> :FzfPreviewBuffers<cr>
map <c-s> :FzfPreviewProjectGrep<cr>
let g:fzf_preview_filelist_command = 'git ls-files --exclude-standard $(git rev-parse --show-toplevel)'

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
