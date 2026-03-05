let g:formatters_python = ['yapf']
let g:formatdef_yapf = '"yapf --style /usr/share/sevensense_linter/yapf_style_100_column_length.cfg"'

nnoremap <buffer> <C-F> V:Autoformat<CR>
inoremap <buffer> <C-F> <C-o>V:Autoformat<CR>
