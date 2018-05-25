" Necessary for multiple encodings
setlocal encoding=utf-8

" Common code for encodings
function! SetFileEncodings(encodings)
        let b:myfileencodingsbak=&fileencodings
        let &fileencodings=a:encodings
endfunction
function! RestoreFileEncodings()
        let &fileencodings=b:myfileencodingsbak
        unlet b:myfileencodingsbak
endfunction

" .NFO specific
autocmd vimrc BufReadPre *.nfo call SetFileEncodings('cp437')|set ambiwidth=single
autocmd vimrc BufReadPost *.nfo call RestoreFileEncodings()
