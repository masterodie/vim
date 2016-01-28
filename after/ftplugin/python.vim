setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal expandtab
setlocal nosmarttab

augroup vimrc_python

augroup END

autocmd vimrc_python FileType python setlocal omnifunc=jedi#completions
