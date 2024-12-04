" load plugins from vundle
set nocompatible
filetype off

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
" syntax on

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

lua vim.cmd [[set runtimepath+=/home/eggerk/.config/nvim/config]]
luafile ~/.config/nvim/config/packer_bootstrap.lua

lua require('plugins')

let g:solarized_italic_comments = v:true
let g:solarized_disable_background = v:true
colorscheme solarized

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Format
noremap <C-F> V:Autoformat<cr>
imap <C-F> <c-o>V:Autoformat<cr>
let g:formatdef_clangformat='"clang-format-12 -style=file -fallback-style=google"'
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:formatters_python=['yapf']
let g:formatdef_yapf = '"yapf --style /usr/share/sevensense_linter/yapf_style_100_column_length.cfg"'

luafile ~/.config/nvim/config/lualine.lua
luafile ~/.config/nvim/config/other_plugin_config.lua

set completeopt=menu,menuone,noselect,noinsert,preview

luafile ~/.config/nvim/config/lsp.lua
lua require('treesitter')

" Avoid showing message extra message when using completion
set shortmess+=c

" Telescope
luafile ~/.config/nvim/config/telescope_settings.lua

" snippets
" Jump forward or backward
imap <expr> <c-l>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <c-l>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <c-h> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <c-h> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

command! CatkinBuildThis execute ":sp term://cd $(dirname %) && catkin build --this --no-deps"
command! CatkinBuildFromThis execute ":sp term://cd $(dirname %) && catkin build --start-with-this"
command! CatkinBuildAll execute ":sp term://cd $(dirname %) && catkin build --this"
command! CatkinTestThis execute ":sp term://cd $(dirname %) && catkin run_tests --this --no-deps"
command! -nargs=+ CatkinBuild execute ":sp term://cd $(dirname %) && catkin build --no-deps " . <f-args>
command! -nargs=+ CatkinBuildWithDeps execute ":sp term://cd $(dirname %) && catkin build " . <f-args>
nmap <leader>bt :CatkinBuildThis<CR>
nmap <leader>ba :CatkinBuildAll<CR>
nmap <leader>tt :CatkinTestThis<CR>

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
