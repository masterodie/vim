"""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" VIM Config - by odie
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Set to Vim Mode
"set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Usability settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Syntax Highlight
syntax on

"Line numbers
set number

"Move over end of line
set whichwrap=<,>,[,],h,l

"Set Tab to 2 spaces
set expandtab
set shiftwidth=2
set softtabstop=2

"Set Leader Key
let mapleader = ","
let maplocalleader = ","

"Auto indentation
set pastetoggle=<F11>
set autoindent
filetype plugin indent on
set smartindent

"Bigger History
set history=1000

"Better Tab Completion
set wildmenu
set wildmode=list:longest

"Make bell visual and disable error bells
set visualbell
set noerrorbells

"Dont move to startofline
set nostartofline

"Activate hidden buffers
set hidden

"Automatically read buffer when changed outside of vim
set autoread


""Search Settings
" Highlight things that we find with the search
set hlsearch
" Ignoring case is a fun trick
set ignorecase
" And so is Artificial Intellegence!
set smartcase
" Incremental searching is sexy
set incsearch

" Set to auto read when a file is changed from the outside
set autoread

"Mouse Select"
set selectmode=mouse

" show the cursor position all the time
"set ruler

"Place backup and temp directory somewhere else
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" keep at least 5 lines above/below
set scrolloff=5
set sidescrolloff=5

"1000 Undos
set undolevels=1000

"Make cursor recognize wrapped lines
map <Down> gj
map <Up> gk
map k gk
map j gj

"Set default Shell
set shell=/bin/zsh


"Automatically cd into the directory that the file is in
"autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
"set autochdir

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Enable persistent undo
if has("persistent_undo")
  set undodir=~/.vim/undo
  set undofile
endif


function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Visual Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""

""Gui Font
set guifont=Envy\ Code\ R:h13

""Antialiasing on
set antialias

""Theme Settings
colorscheme zenburn
set t_Co=256
""let g:solarized_termcolors=256
""let g:solarized_termtrans=1


"Status line gnarliness
set laststatus=2
set statusline=%-60.60(%F%m%r%w%)%=%((%{&ff})\ %y%)%30.30([%v][%l/%L]%7.7([%p%%]%)%)

hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal
hi SpellBad cterm=bold,undercurl
hi SpellBad ctermfg=darkred
hi SpellCap cterm=undercurl
hi SpellCap ctermfg=darkred
hi SpellRare cterm=bold,undercurl
hi SpellRare ctermfg=darkgreen
hi SpellLocal cterm=bold,undercurl
hi SpellLocal ctermfg=darkblue


""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Spell check settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Use english for spellchecking, but don't spellcheck by default
if version >= 700
   set spl=de_20,en_us
   set nospell
   map <F12> :set spell!<CR>
else
   "Spell Checking with aspell on F12
   map <F12> :w!<CR>:!aspell --lang=de_DE check %<CR>:e! %<CR>
endif

set tags=~/.vim/tags
set tags+=./tags;

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin on
filetype indent on

"""Auto Completion Settings

"setlocal omnifunc=javacomplete#Complete
"setlocal completefunc=javacomplete#CompleteParamsInfo

""" Buftabs
"Buffer Settings
let g:buftabs_only_basename=1

""" vim-latex
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

""" NERDTree
nnoremap <F3>  :NERDTreeToggle<CR>

""" TagList
nnoremap <F4>  :TlistToggle<CR>
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 25

""" UndoTree
nnoremap <F5> :UndotreeToggle<CR>
nnoremap <leader>u :UndotreeToggle<CR>

""" Java Settings
"nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
"nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
"nnoremap <silent> <buffer> <cr>      :JavaSearchContext<cr>

"""
" Jekyll Settings
"""

"let g:jekyll_path = "~/Dokumente/Projects/Blog"
"let g:jekyll_build_command = '/Users/odie/.rvm/rubies/ruby-1.9.3-p392/bin/ruby /Users/odie/.rvm/rubies/ruby-1.9.3-p392/bin/jekyll --no-auto --no-server'

"""
" SrcEpl
"""

nmap <F6> :SrcExplToggle<CR>

"""
" Pathogen
"""

call pathogen#infect()
call pathogen#helptags()

"""
" MRU
"""

nmap <F2> :MRU<CR>

"""
" NFO files
"""

" Necessary for multiple encodings
set encoding=utf-8

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
au BufReadPre *.nfo call SetFileEncodings('cp437')|set ambiwidth=single
au BufReadPost *.nfo call RestoreFileEncodings()

" Minibufexplorer
let g:miniBufExplorerMoreThanOne = 2
let g:miniBufExplModSelTarget = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

"Delimitmate
let delimitMate_matchpairs = '(:),[:],{:},<:>'
let delimitMate_quotes = "\" ' ` | %"

"Closetag
"autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
"autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag.vim/plugin/closetag.vim
"
"Ragtag
let g:ragtag_global_maps = 1
