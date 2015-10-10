"""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" VIM Config - by odie
""" vim:fdm=marker
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable UTF-8 Mode
scriptencoding utf-8
" Set to Vim Mode
set nocompatible

if has('win32')
    source $VIMRUNTIME/mswin.vim
endif

""" Autocommand Group {{{
augroup vimrc
    autocmd!
    autocmd BufWritePost ~/.vimrc :source ~/.vimrc
    autocmd BufWritePost ~/.vim/vimrc :source ~/.vimrc
augroup END


""" }}}
""" Plug {{{
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
let path='~/.vim/bundle'
if has('win32')
    set rtp+=~/vimfiles/bundle/Vundle.vim/
    let path='~/vimfiles/bundle'
endif
call plug#begin(path)

"Colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'jnurmine/Zenburn'
Plug 'sickill/vim-monokai'
Plug '29decibel/codeschool-vim-theme'
Plug 'tomasr/molokai'

"" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'rdolgushin/gitignore.vim'

"Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"Completion
if has('nvim')
    Plug 'Shougo/deoplete.nvim'
else
    Plug 'Shougo/neocomplete.vim'
endif

Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'thisivan/vim-bufexplorer'
Plug 'groenewege/vim-less'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'sukima/xmledit'
Plug 'plasticboy/vim-markdown'
Plug 'edkolev/tmuxline.vim'
Plug 'joedicastro/vim-pentadactyl'
Plug 'rendermani/vim-multiple-cursors'
Plug 'sickill/vim-pasta'
Plug 'benmills/vimux'
Plug 'jmcantrell/vim-virtualenv'
Plug 'davidhalter/jedi-vim'
Plug 'python-rope/ropevim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'hdima/python-syntax'
Plug 'tmhedberg/SimpylFold'
Plug 'lepture/vim-jinja'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'majutsushi/tagbar'
Plug 'ervandew/supertab'
Plug 'tpope/vim-repeat'

call plug#end()            " required
filetype plugin indent on    " required

""" }}}
""" Functions {{{
" recursively search up from dirname, sourcing all .vimrc.local files along the way
function! ApplyLocalSettings(dirname)
    " convert windows paths to unix style
    let l:curDir = substitute(a:dirname, '\\', '/', 'g')

    " walk to the top of the dir tree
    let l:parentDir = strpart(l:curDir, 0, strridx(l:curDir, '/'))
    if isdirectory(l:parentDir)
        call ApplyLocalSettings(l:parentDir)
    endif

    " now walk back down the path and source .vimsettings as you find them.
    " child directories can inherit from their parents
    let l:settingsFile = a:dirname . '/.vimrc.local'
    if filereadable(l:settingsFile)
        exec ':source' . l:settingsFile
    endif
endfunction

function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif

endfunc
""" }}}
"" Visual Settings {{{
" Line numbers
set number
" Make bell visual and disable error bells
set visualbell
" Disable error bells
set noerrorbells
" Show (partial) command in status line
set showcmd
" Enable statusline for single buffer
set laststatus=2
" Faster redrawing
set ttyfast
" Colorize column 80
set colorcolumn=80
"" }}}
"" Keyboard Settings {{{


"Move over end of line
set whichwrap=b,s,<,>,[,],h,l
" Backspace over autoindent, line breaks, start of insert (see :help 'backspace')
set backspace=indent,eol,start
"Set Tab to expand into spaces
set expandtab
"Auto indentation
set autoindent
"Smart indentation
set smartindent
"Smart tab
set smarttab
"Tab Width
set tabstop=4
set shiftwidth=4

""" }}}
""" Key Bindings {{{
" Paste mode toggle key
set pastetoggle=<F11>

"Set Leader Key
let g:mapleader = ","
let g:maplocalleader = ","

"Make cursor recognize wrapped lines
map <Down> gj
map <Up> gk
map k gk
map j gj

" Split management with CTRL + movement keys
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Quit buffer
nmap <C-y> :q<CR>
" Quick save mapping
nmap <leader>, :w<CR>
" Disable ex mode
noremap Q <NOP>

nmap <leader>rel :call NumberToggle()<cr>

nmap <leader>vimrc :e ~/.vimrc<cr>
nmap <leader>vr :source ~/.vimrc<cr>

""" }}}
"" Mouse Settings {{{

if has('mouse')
    set mouse=a
    "set ttymouse=xterm2
    "Mouse select
    set selectmode=mouse
endif

"" }}}
"" Search Settings {{{

"Better Tab Completion
set wildmenu
set wildmode=list:longest
" Highlight things that we find with the search
set hlsearch
" Ignoring case is a fun trick
set ignorecase
" And so is Artificial Intellegence!
set smartcase
" Incremental searching is sexy
set incsearch

"" }}}
"" Misc Settings {{{

"Bigger History
set history=1000
" keep at least 5 lines above/below
set scrolloff=5
set sidescrolloff=5
"1000 Undos
set undolevels=1000
"Dont move to startofline
set nostartofline
"Activate hidden buffers
set hidden
"Automatically read buffer when changed outside of vim
set autoread
"Place backup and temp directory somewhere else
set backup

"Compatibility options
set cpoptions+=d


if has("win32")
    set backupdir=~/vimfiles/backup
    set directory=~/vimfiles/tmp
    set tags=./.tags,~/vimfiles/tags,tags
else
    set tags=./.tags,~/.vim/tags,tags
    set backupdir=~/.vim/backup
    set directory=~/.vim/tmp
endif

" Enable persistent undo {{{
if has("persistent_undo")
    set undofile
    if has("win32")
        set undodir=~/vimfiles/undo
    else
        set undodir=~/.vim/undo
    endif
endif

" }}}
" Remove any trailing whitespace that is in the file {{{
autocmd vimrc BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
"Restore Last Cursor Position
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
"}}}
""" }}}
"" Plugin Settings {{{
" Enable Syntax Highlighting
syntax on
filetype plugin on
filetype indent on

"" NERDTree {{{
nnoremap <F3>  :NERDTreeToggle<CR>
"" }}}
"" Tagbar {{{
nnoremap <F4>  :TagbarToggle<CR>
let g:tagbar_iconchars = ['▸', '▾']
"" }}}
"" Easytags {{{
" let g:easytags_cmd = '/usr/local/bin/ctags'
let g:easytags_dynamic_files = 2
map <S-F11> :!ctags -R -f $VIRTUAL_ENV/.tags $VIRTUAL_ENV/lib/python3.5/site-packages<CT>
set tags+=$VIRTUAL_ENV/.tags
"" }}}
"" Delimitmate {{{
"let delimitMate_matchpairs = '(:),[:],{:},<:>'
"" }}}
"" Ragtag {{{
let g:ragtag_global_maps = 1
" }}}
"" vim-ruby {{{
autocmd vimrc FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd vimrc FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd vimrc FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd vimrc FileType ruby,eruby let g:rubycomplete_rails = 1

let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_load_gemfile = 1

"" }}}
"" vim-project {{{
let g:project_use_nerdtree = 1
"call project#rc("~/Documents/Projects/")
if has('win32')
    set rtp+=~/vimfiles/bundle/vim-project/
else
    set rtp+=~/.vim/bundle/vim-project/
endif
"" }}}
"" CtrlP {{{
noremap <leader>p <Esc>:CtrlP<CR>
noremap <leader>o <Esc>:CtrlPBuffer<CR>
noremap <leader>m <Esc>:CtrlPMixed<CR>
"" }}}
"" python-Mode {{{
let g:pymode_virtualenv = 0
let g:pymode_lint = 0
let g:pymode_rope = 0
let g:pymode_rope_complete_on_dot = 1
let g:pymode_rope_completion = 1
let g:pymode_rope_autoimport = 1
let g:pymode_rope_autoimport_import_after_complete = 0
let g:pymode_rope_autoimport_modules = ['os', 'shutil', 'datetime', 'django.*']
"" }}}
"" Airline {{{

let g:airline_powerline_fonts = 1
let g:airline_theme = "molokai"
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#whitespace#trailing_format = '●[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = '○[%s]'
"" }}}
"" Syntastic {{{
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_aggregate_errors = 1
"" }}}
"" Ultisnips {{{
"""" OWN SETTINGS
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

""""NEW SETTINGS
"let g:UltiSnipsExpandTrigger       = "<c-j>"
"let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
"let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
"let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file

let g:snips_author = "Patrick Neff"
let g:snips_email = "odie86@gmail.com"
let g:snips_github = "https://github.com/masterodie"
"" }}}
"" jedi-vim {{{
"autocmd FileType python setlocal omnifunc=jedi#completions
let g:virtualenv_auto_activate = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
let g:jedi#auto_close_doc = 1
"let g:jedi#force_py_version = 3
"" }}}
"" ropevim {{{
let ropevim_vim_completion = 0
let ropevim_extended_complete = 1
let ropevim_enable_autoimport = 1
let g:ropevim_autoimport_modules = ['os', 'shutil', 'datetime', 'flask.*']
"" }}}
"" python syntax {{{
let python_highlight_all = 1
"" }}}
"" SympylFold {{{
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 1
"" }}}
"" vim-pasta {{{
let g:pasta_enabled_filetypes = ['python', 'ruby', 'javascript', 'css', 'c', 'sh']
"" }}}
"" neocomplete {{{
if !has('nvim')
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
autocmd FileType python setlocal omnifunc=jedi#completions
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:neocomplete#enable_auto_select=1
endif
"" }}}
"" deoplete {{{
if has('nvim')
if !exists('g:deoplete#force_omni_input_patterns')
        let g:deoplete#force_omni_input_patterns = {}
endif
autocmd FileType python setlocal omnifunc=jedi#completions
let g:deoplete#enable_at_startup = 1
let g:deoplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:deoplete#enable_auto_select=1
endif
"" }}}
""" }}}
""" Status Line {{{
set laststatus=2
""" }}}
"" Theme Settings {{{
set t_Co=256
colorscheme molokai
set background=dark
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
call togglebg#map("<F7>")
"" }}}
""" GUI Sttings {{{

if has("gui_running")
    "" Gui Font
    if has("gui_gtk2")
        set guifont=Terminess\ Powerline\ 8
        set guioptions=eg
    elseif has("gui_macvim")
        set guifont=Anonymous\ Pro:h12
    elseif has("gui_win32")
        set guifont=Anonymice\ Powerline:h12
        set guioptions=eg
    endif

    "" Antialiasing on
    set antialias
endif

""" }}}


call ApplyLocalSettings('.')
