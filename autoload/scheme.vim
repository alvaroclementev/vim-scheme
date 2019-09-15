function! scheme#connect()
  " TODO: Add support for vertical splitting (see h:term_start options)
  if has('terminal')
      let s:repl_term_id = term_start('guile', {'term_finish': 'close'})
  else
      new
      let s:repl_term_id = termopen('mit-scheme')
  endif

  if g:scheme_split_size != "default"
    silent execute "resize " . g:scheme_split_size
  endif

  normal! G
endfunction

function! scheme#eval(type)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@

  if a:0
    silent exe "normal! `<" . a:type . "`>y"
  elseif a:type == 'line'
    silent exe "normal! '[V']y"
  elseif a:type == 'block'
    silent exe "normal! `[\<C-V>`]y"
  else
    silent exe "normal! `[v`]y"
  endif

  if has('terminal')
      call term_sendkeys(s:repl_term_id, @@ . "\n")
  else
      call jobsend(s:repl_term_id, @@ . "\n")
  endif

  let &selection = sel_save
  let @@ = reg_save
endfunction

