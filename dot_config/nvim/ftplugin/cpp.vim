let g:formatdef_clangformat='"clang-format-12 -style=file -fallback-style=google"'

nnoremap <buffer> <C-F> V:Autoformat<CR>
inoremap <buffer> <C-F> <C-o>V:Autoformat<CR>
