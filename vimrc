"""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" VIM Config - by odie
""" vim:fdm=marker
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable UTF-8 Mode
set encoding=utf-8
scriptencoding utf-8
" Set to Vim Mode
set nocompatible

if has('win32')
    source $VIMRUNTIME/mswin.vim
endif

""" Autocommand Group {{{
augroup vimrc
    autocmd!
augroup END
""" }}}
""" Vundle {{{
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
let path='~/.vim/bundle'
if has('win32')
    set rtp+=~/vimfiles/bundle/Vundle.vim/
    let path='~/vimfiles/bundle'
endif
call vundle#begin(path)

"Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

"Colorschemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'
Plugin 'sickill/vim-monokai'

"Plugins
Plugin 'Raimondi/delimitMate'
Plugin 'vim-scripts/loremipsum'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'thisivan/vim-bufexplorer'
Plugin 'tpope/vim-bundler'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-fugitive'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-ragtag'
Plugin 'groenewege/vim-less'
Plugin 'StanAngeloff/php.vim'
Plugin 'scrooloose/syntastic'
Plugin 'amiorin/vim-project'
Plugin 'vim-scripts/VimRepress'
Plugin 'msanders/cocoa.vim'
Plugin 'tpope/vim-pathogen'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'craigemery/vim-autotag'
Plugin 'bling/vim-airline'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'sukima/xmledit'
Plugin 'plasticboy/vim-markdown'
Plugin 'edkolev/tmuxline.vim'
if has('ruby')
    Plugin 'tpope/vim-rails'
    Plugin 'thoughtbot/vim-rspec'
    Plugin 'vim-ruby/vim-ruby'
    Plugin 'tpope/vim-endwise'
endif

if has('python')
    if !has('win32')
        Plugin 'klen/python-mode'
    endif
    Plugin 'SirVer/ultisnips'
    Plugin 'honza/vim-snippets'
endif

if filereadable("/usr/bin/ctags")
    Plugin 'xolox/vim-easytags'
endif

if has("patch-7.3.584")
    Plugin 'Valloric/YouCompleteMe'
endif

call vundle#end()            " required
filetype plugin indent on    " required

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
"" }}}
"" Theme Settings {{{
set background=dark
colorscheme solarized
"set t_Co=256
let g:solarized_termcolors=256
let g:solarized_termtrans=1
call togglebg#map("<F7>")
"" }}}
"" Plugin Settings {{{
" Enable Syntax Highlighting
syntax on
filetype plugin on
filetype indent on

""" }}}
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

if has("win32")
    set backupdir=~/vimfiles/backup
    set directory=~/vimfiles/tmp
    set tags=~/vimfiles/tags,./tags,tags
else
    set tags=~/.vim/tags,./tags,tags
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
        set undofile
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
"" Mouse Setings {{{
"Mouse select
set selectmode=mouse
"" }}}
""" Status Line {{{
set laststatus=2
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

""" }}}
"" Theme Settings {{{
set background=dark
set t_Co=256
colorscheme solarized
call togglebg#map("<F7>")
"" }}}
""" GUI Sttings {{{

if has("gui_running")
    "" Gui Font
    if has("gui_gtk2")
        set guifont=Droid\ Sans\ Mono\ 10
    elseif has("gui_macvim")
        set guifont=Droid\ Sans\ Mono\ for\ Powerline:h12
    elseif has("gui_win32")
        set guifont=Droid\ Sans\ Mono:h10:cANSI
        set guioptions=eg
    endif

    "" Antialiasing on
    set antialias
endif

""" }}}
""" Plugins {{{
"" NERDTree {{{
nnoremap <F3>  :NERDTreeToggle<CR>
"" }}}
"" Tagbar {{{
nnoremap <F4>  :TagbarToggle<CR>
"" }}}
"" Easytags {{{
" let g:easytags_cmd = '/usr/local/bin/ctags'
let g:easytags_dynamic_files = 1
"" }}}
"" Delimitmate {{{
let delimitMate_matchpairs = '(:),[:],{:},<:>'
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
"" command-t {{{
noremap <leader>o <Esc>:CtrlP<CR>
noremap <leader>m <Esc>:CtrlPMixed<CR>
"" }}}
"" python-Mode {{{
let g:pymode_options = 1
" pylint {{{
let g:pymode_pylint = 0
" }}}
" rope {{{
let g:pymode_rope = 1
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_completion = 0
" }}}
autocmd vimrc FileType python setlocal formatoptions+=t
"" }}}
"" Airline {{{

let g:airline_powerline_fonts = 1
let g:airline_theme = "solarized"
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
"" YouCompleteMe {{{
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"" }}}
"" Ultisnips {{{
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"" }}}
""" }}}

