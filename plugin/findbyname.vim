function! s:OpenQuickList(data)
  silent! botright 10split __QuickList__
  normal! ggdG

  setlocal buftype=nofile
  setlocal bufhidden=delete
  setlocal noswapfile
  setlocal nowrap
  setlocal nobuflisted

  call append(0, a:data)

  nnoremap <buffer> <silent> <CR> :call s:OpenQuickListFile()<CR>
endfunction

function! s:OpenQuickListFile() range
  let fnames = getline(a:firstline, a:lastline)
  if len(fnames) <=# 0
    return
  endif

  silent! close

  for fname in fnames
    if len(fname) ==# 0 || strpart(fname, 0, 1) ==# '#'
      continue
    endif
    exe 'tabnew ' . fname
  endfor
endfunction

function! RunFindByName(name, ...)
  let dir = '.'
  if a:0 ># 0
    let dir = a:1
  endif

  let message = 'Searching for filename matching: ' . a:name . " in " . dir
  echom message

  let find_command = "find " . dir . " -type f -name \\*" . a:name . "\\*"
  let results = split(system(find_command), '\n')
  if v:shell_error
    echom "Error running find command."
    return
  endif
  if len(results) ==# 0
    call add(results, '# No results.')
  endif
  call insert(results, '# ' . message, 0)
  call s:OpenQuickList(results)
endfunction

command! -nargs=* FindByName call RunFindByName(<f-args>)
