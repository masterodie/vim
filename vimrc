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
Plugin '29decibel/codeschool-vim-theme'
Plugin 'tomasr/molokai'

"Plugins
Plugin 'Raimondi/delimitMate'
"Plugin 'vim-scripts/loremipsum'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'thisivan/vim-bufexplorer'
"Plugin 'tpope/vim-bundler'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-fugitive'
Plugin 'groenewege/vim-less'
Plugin 'StanAngeloff/php.vim'
Plugin 'scrooloose/syntastic'
Plugin 'amiorin/vim-project'
"Plugin 'vim-scripts/VimRepress'
"Plugin 'msanders/cocoa.vim'
"Plugin 'tpope/vim-pathogen'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
"Plugin 'craigemery/vim-autotag'
Plugin 'bling/vim-airline'
Plugin 'sukima/xmledit'
Plugin 'plasticboy/vim-markdown'
Plugin 'edkolev/tmuxline.vim'
Plugin 'joedicastro/vim-pentadactyl'
Plugin 'edsono/vim-matchit'
Plugin 'rendermani/vim-multiple-cursors'
Plugin 'Shougo/neocomplete.vim'
Plugin 'ervandev/supertab'
Plugin 'tpope/vim-git.git'
Plugin 'rdolgushin/gitignore.vim'
Plugin 'Rip-Rip/clang_complete'
Plugin 'sickill/vim-pasta'

if has('ruby')
    Plugin 'tpope/vim-rails'
    Plugin 'thoughtbot/vim-rspec'
    Plugin 'vim-ruby/vim-ruby'
    Plugin 'tpope/vim-endwise'
    Plugin 'tpope/vim-ragtag'
endif

if has('python')
    "Plugin 'klen/python-mode'
    Plugin 'jmcantrell/vim-virtualenv'
    Plugin 'davidhalter/jedi-vim'
    Plugin 'python-rope/ropevim'
    "Plugin 'nvie/vim-flake8'
    Plugin 'SirVer/ultisnips'
    Plugin 'honza/vim-snippets'
    Plugin 'hynek/vim-python-pep8-indent'
    Plugin 'hdima/python-syntax'
    Plugin 'tmhedberg/SimpylFold'
    Plugin 'lepture/vim-jinja'
endif

if filereadable("/usr/bin/ctags")
    Plugin 'xolox/vim-easytags'
    "Plugin 'vim-scripts/taglist.vim'
    "Plugin 'szw/vim-tags'
    Plugin 'xolox/vim-misc'
    Plugin 'majutsushi/tagbar'
endif

if has("patch-7.3.584")
    if !has("win32")
        "Plugin 'Valloric/YouCompleteMe'
    else
        "Plugin 'file:///C:/Applications/vim/youcompleteme/'
    endif
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
" Faster redrawing
set ttyfast
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

""" }}}
"" Mouse Settings {{{

if has('mouse')
    set mouse=a
    set ttymouse=xterm2
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

" Quit buffer
nmap <C-x> :q<CR>
" Quick save mapping
nmap <leader>, :w<CR>
" Disable ex mode
noremap Q <NOP>

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
        set guifont=Inconsolata\ for\ Powerline\ 11
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
""" Plugins {{{
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
"" command-t {{{
noremap <leader>o <Esc>:CtrlP<CR>
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
"" YouCompleteMe {{{
"""" OWN SETTINGS
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

"""NEW SETTINGS
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'python' : 1,
      \ 'mail' : 1
      \}
"" }}}
"" Ultisnips {{{
"""" OWN SETTINGS
"let g:UltiSnipsExpandTrigger = "<tab>"
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"""NEW SETTINGS
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file

let g:snips_author = "Patrick Neff"
let g:snips_email = "odie86@gmail.com"
let g:snips_github = "https://github.com/masterodie"
"" }}}
"" jedi-vim {{{
let g:neocomplete#enable_at_startup = 1
"autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
let g:jedi#auto_close_doc = 1
let g:jedi#force_py_version = 2
"" }}}
"" neocomplete {{{
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
"" }}}
"" ropevim {{{
let ropevim_vim_completion = 0
let ropevim_extended_complete = 1
let ropevim_enable_autoimport = 1
let g:ropevim_autoimport_modules = ['os', 'shutil', 'datetime', 'django.*']
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
""" }}}

