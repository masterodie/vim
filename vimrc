"""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" VIM Config - by odie
""" vim:fdm=marker
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable UTF-8 Mode
set encoding=utf-8
scriptencoding utf-8
" Set to Vim Mode
set nocompatible

runtime bundle/pathogen/autoload/pathogen.vim

""" Autocommand Group {{{
augroup vimrc
        autocmd!
augroup END
""" }}}
""" Editor Settings {{{
"" Plugin Settings {{{
" Enable Syntax Highlighting
syntax on
filetype plugin on
filetype indent on

""" }}}
"" Pathogen {{{

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []

call add(g:pathogen_disabled, 'command-t')

if !has('ruby')
        call add(g:pathogen_disabled, 'vim-ruby')
        call add(g:pathogen_disabled, 'vim-rails')
        call add(g:pathogen_disabled, 'vim-rspec')
        call add(g:pathogen_disabled, 'vim-endwise')
endif

if !has('python')
        call add(g:pathogen_disabled, 'ultisnips')
        call add(g:pathogen_disabled, 'pymode')
        call add(g:pathogen_disabled, 'jedi-vim')
endif

if !filereadable("/usr/bin/ctags")
        call add(g:pathogen_disabled, 'vim-easytags')
endif

call pathogen#infect()
call pathogen#helptags()

"" }}}
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
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
" Set Tags file for exubertant-ctags
set tags=~/.vim/tags,./tags,tags
" Enable persistent undo {{{
if has("persistent_undo")
        set undodir=~/.vim/undo
        set undofile
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
""" GUI Sttings {{{

if has("gui_running")
        "" Gui Font
        if has("gui_gtk2")
                set guifont=Droid\ Sans\ Mono\ 10
        elseif has("gui_macvim")
                set guifont=Droid\ Sans\ Mono\ for\ Powerline:h12
        elseif has("gui_win32")
                set guifont=Consolas:h11:cANSI
        endif

        "" Antialiasing on
        set antialias
endif

""" }}}
""" Spell check settings {{{


" Use english for spellchecking, but don't spellcheck by default
if version >= 700
        set spl=de_20,en_us
        set nospell
        map <F12> :set spell!<CR>
else
        "Spell Checking with aspell on F12
        map <F12> :w!<CR>:!aspell --lang=de_DE check %<CR>:e! %<CR>
endif



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
set rtp+=~/.vim/bundle/vim-project/
call project#rc("~/Documents/Projects/")

Project  '~/.vim' , 'vim'
Project  '~/.dotfiles' , 'dotfiles'
Project  '~/code/python/Cards', 'Python Cards'
Project  '~/code/python/ternary27', 'ternary27'
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
let g:airline_theme = "zenburn"
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
let g:ycm_key_list_previous_completion=['<Up>']
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
"" }}}
"" Ultisnips {{{
"let g:UltiSnipsExpandTrigger="<c-tab>"
"let g:UltiSnipsListSnippets="<c-s-tab>"
"" }}}
""" }}}
