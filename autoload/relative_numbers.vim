" Toggle relative number
function! NumberToggle() abort
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction

