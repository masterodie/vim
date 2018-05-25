setlocal shiftwidth=2

let b:delimitMate_matchpairs = '(:),[:],{:}'

unlet! b:did_ftplugin
source $HOME/.vim/bundle/xmledit/ftplugin/html.vim
source $HOME/.vim/bundle/xmledit/ftplugin/xml.vim
