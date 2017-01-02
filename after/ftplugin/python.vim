setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal expandtab
setlocal nosmarttab

let testrunner = 'py.test'

augroup vimrc_python

augroup END

if has('nvim')
else
    autocmd vimrc_python FileType python setlocal omnifunc=jedi#completions
endif
