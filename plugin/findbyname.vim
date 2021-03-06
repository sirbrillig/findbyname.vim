if !exists("FindByName_Use_Tabs")
    let FindByName_Use_Tabs = 'false'
endif

function! s:OpenQuickList(data)
  let winnum = bufwinnr('__QuickList__')
  if winnum != -1
    if winnum != winnr()
      exe winnum . 'wincmd w'
    endif
  else
    silent! botright 10split __QuickList__
  endif
  setlocal modifiable
  normal! ggdG

  setlocal buftype=nofile
  setlocal bufhidden=delete
  setlocal noswapfile
  setlocal nowrap
  setlocal nobuflisted

  call append(0, a:data)

  $delete
  normal! gg
  setlocal nomodifiable

  nnoremap <buffer> <silent> <CR> :call OpenFindByNameQuickListFile()<CR>
endfunction

function! OpenFindByNameQuickListFile() range
  let fnames = getline(a:firstline, a:lastline)
  if len(fnames) <=# 0
    return
  endif

  silent! close

  for fname in fnames
    if len(fname) ==# 0 || strpart(fname, 0, 1) ==# '#'
      continue
    endif
    call s:CreateNewBufferForFile(fname)
  endfor
endfunction

function! s:CreateNewBufferForFile(fname)
  if g:FindByName_Use_Tabs ==# 'true'
    exe 'tabnew ' . a:fname
  else
    exe 'edit ' . a:fname
  endif
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

command! -nargs=* -complete=file FindByName call RunFindByName(<f-args>)
