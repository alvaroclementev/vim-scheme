command! SchemeConnect call scheme#connect()

let g:scheme_split_size = get(g:, "scheme_split_size", "default")

augroup filetype_scheme
    autocmd!
    autocmd FileType scheme nnoremap <buffer> cp :set opfunc=scheme#eval<cr>g@
    autocmd FileType scheme nnoremap <buffer> cpp :normal cpaf<cr>
    autocmd FileType scheme vnoremap <buffer> <Leader>cp :<C-U>call scheme#eval(visualmode())<CR>
augroup END
