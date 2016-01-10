"""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" VIM Config - by odie
""" vim:fdm=marker
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable UTF-8 Mode
scriptencoding utf-8
" Set to Vim Mode
set nocompatible

" Load windows Environment
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
""" Settings {{{
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

"" Keybindings
" Paste mode toggle key
set pastetoggle=<F11>

"Set Leader Key
let g:mapleader = ","
let g:maplocalleader = ";"
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

" Status Line
set laststatus=2
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
"" }}}
""" PlugIns {{{
syntax on
filetype plugin on
filetype indent on
" filetype off
" !Plug Path {{{
let path='~/.vim/bundle'
if has('nvim')
    let path='~/.config/nvim/bundle'
elseif has('win32')
    let path='~/vimfiles/bundle'
endif
" }}}
" !Plug Start {{{
call plug#begin(path)
" }}}

"" Colorschemes {{{
" vim-colors-solarized {{{
Plug 'altercation/vim-colors-solarized'
" }}}
" Zenburn {{{
Plug 'jnurmine/Zenburn'
" }}}
" vim-monokai {{{
Plug 'sickill/vim-monokai'
" }}}
" codeschool-vim-theme {{{
Plug '29decibel/codeschool-vim-theme'
" }}}
" molokai {{{
Plug 'tomasr/molokai'
" }}}
"" }}}
"" Git {{{
" vim-fugitive {{{
Plug 'tpope/vim-fugitive'
" }}}
" vim-git {{{
Plug 'tpope/vim-git'
" }}}
" gitignore.vim {{{
Plug 'rdolgushin/gitignore.vim'
" }}}
"" }}}
"" Snippets {{{
" ultisnips {{{
Plug 'SirVer/ultisnips'
"let g:UltiSnipsExpandTrigger = "<tab>"
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:snips_author = "Patrick Neff"
let g:snips_email = "odie86@gmail.com"
let g:snips_github = "https://github.com/masterodie"
" }}}
" vim-snippets {{{
Plug 'honza/vim-snippets'
" }}}
"" }}}
"" Completion {{{
" neocomplete.vim {{{
if !has('nvim')
Plug 'Shougo/neocomplete.vim'
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
"let g:neocomplete#enable_auto_select=0
endif
" }}}
" deoplete.vim {{{
if has('nvim')
Plug 'Shougo/deoplete.nvim'
if !exists('g:deoplete#force_omni_input_patterns')
        let g:deoplete#force_omni_input_patterns = {}
endif
autocmd vimrc FileType python setlocal omnifunc=jedi#completions
autocmd vimrc FileType python setlocal completefunc=jedi#completions
let g:deoplete#enable_at_startup = 1
let g:deoplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
"let g:deoplete#enable_auto_select=0
endif
" }}}
" supertab {{{
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
let g:SuperTabContextDefaultCompletionType = "<c-p>"
" }}}
""  }}}
"" Delimiters {{{
" delimitMate {{{
Plug 'Raimondi/delimitMate'
"let delimitMate_matchpairs = '(:),[:],{:},<:>'
au FileType python let b:delimitMate_nesting_quotes = ['"']
au FileType python let b:delimitMate_expand_cr = 1
au FileType python let b:delimitMate_expand_inside_quotes = 1
" }}}
" vim-surround {{{
Plug 'tpope/vim-surround'
autocmd vimrc FileType jinja let b:surround_45 = "{{ \r }}"
autocmd vimrc FileType jinja let b:surround_95 = "{% \r %}"
autocmd vimrc FileType python let b:surround_45 = "_(\r)"
" }}}
" vim-repeat {{{
Plug 'tpope/vim-repeat'
" }}}
"" }}}
"" File Browsing  {{{
" nerdtree {{{
Plug 'scrooloose/nerdtree'
nnoremap <F3>  :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '__pycache__$[[dir]]', '\~$']
" }}}
" vim-bufexplorer {{{
Plug 'thisivan/vim-bufexplorer'
" }}}
" ctrlp.vim {{{
Plug 'kien/ctrlp.vim'
noremap <leader>m <Esc>:CtrlP<CR>
noremap <leader>p <Esc>:CtrlPBuffer<CR>
noremap <leader>o <Esc>:CtrlPMixed<CR>
" }}}
"" }}}
"" Comments {{{
" nerdcommenter {{{
Plug 'scrooloose/nerdcommenter'
" }}}
"" }}}
"" Syntax {{{
" syntastic {{{
Plug 'scrooloose/syntastic'
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_aggregate_errors = 1
" }}}
"" }}}
"" Markdown {{{
" vim-markdown {{{
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
" }}}
"" }}}
"" Tmux {{{
" vimux {{{
Plug 'benmills/vimux'
" }}}
"" }}}
"" Statusline {{{
" vim-airline {{{
Plug 'bling/vim-airline'
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
" }}}
" tmuxline.vim {{{
Plug 'edkolev/tmuxline.vim'
" }}}
"" }}}
"" Ctags {{{
" vim-easytags {{{
"Plug 'xolox/vim-easytags'
" let g:easytags_cmd = '/usr/local/bin/ctags'
let g:easytags_dynamic_files = 2
map <S-F11> :!ctags -R -f $VIRTUAL_ENV/.tags $VIRTUAL_ENV/lib/python3.5/site-packages<CT>
set tags+=$VIRTUAL_ENV/.tags
" }}}
" vim-misc {{{
"Plug 'xolox/vim-misc'
" }}}
" tagbar {{{
"Plug 'majutsushi/tagbar'
nnoremap <F4>  :TagbarToggle<CR>
let g:tagbar_iconchars = ['▸', '▾']
" }}}
"" }}}
"" Python {{{
" vim-virtualenv {{{
Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}
let g:virtualenv_auto_activate = 1
" }}}
" jedi-vim {{{
Plug 'davidhalter/jedi-vim', {'for': 'python'}
autocmd vimrc FileType python setlocal omnifunc=jedi#completions
autocmd vimrc FileType python setlocal completefunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#show_call_signatures = 0
"let g:jedi#force_py_version = 3
" }}}
" ropevim {{{
"Plug 'python-rope/ropevim', {'for': 'python'}
let ropevim_vim_completion = 0
let ropevim_extended_complete = 0
let ropevim_enable_autoimport = 1
let g:ropevim_autoimport_modules = ['os', 'shutil', 'datetime', 'flask.*']
" }}}
" vim-python-pep8-indent {{{
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
" }}}
" python-syntax {{{
Plug 'hdima/python-syntax', {'for': 'python'}
let python_highlight_all = 1
" }}}
" SimpylFold {{{
Plug 'tmhedberg/SimpylFold', {'for': 'python'}
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 1
" }}}
"" }}}
"" JavaScript {{{
autocmd vimrc FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" vim-javascript {{{
" Plug 'pangloss/vim-javascript'
" }}}
" jslint.vim {{{
" Plug 'hallettj/jslint.vim'
" }}}
" vim-jquery {{{
Plug 'nono/jquery.vim'
" }}}
"" }}}
"" LUA {{{
Plug 'xolox/vim-lua-ftplugin', {'for': ['lua']}
"" }}}
"" HTML {{{
" xmledit', {'for': ['html', 'xml', 'jinja {{{
Plug 'sukima/xmledit', {'for': ['html', 'xml', 'jinja']}
" }}}
"" }}}
"" Jinja {{{
" vim-jinja {{{
Plug 'lepture/vim-jinja'
" }}}
"" }}}
"" Less {{{
" vim-less {{{
Plug 'groenewege/vim-less'
" }}}
"" }}}
"" Pentadactyl {{{
" vim-pentadactyl {{{
Plug 'joedicastro/vim-pentadactyl'
" }}}
"" }}}
"" Vimperator {{{
" vim-vimperator {{{
Plug 'TluxGhelew/vim-vimperator'
" }}}
"" }}}
"" gettext {{{
Plug 'vim-scripts/po.vim'
let g:po_translator = "Patrick Neff <odie86@gmail.com>"
let g:po_lang_team = "myself"

Plug 'vim-scripts/po.vim--gray'
"" }}}
"" Tests {{{
" vim-test {{{
Plug 'janko-m/vim-test'
" make test commands execute using dispatch.vim
let test#strategy = "vimux"
let test#python#nose#options = '--verbose'
let g:test#preserve_screen = 1
" }}}
"" }}}
"" Misc {{{
" vim-pasta {{{
Plug 'sickill/vim-pasta'
let g:pasta_enabled_filetypes = ['python', 'ruby', 'javascript', 'css', 'c', 'sh']
" }}}
"" }}}

" !Plug Stop {{{
call plug#end()            " required
" }}}
""" }}}
""" Visual {{{
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
"" GUI Sttings {{{
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
"" Theme Settings {{{
set t_Co=256
colorscheme molokai
set background=dark
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
call togglebg#map("<F7>")
"" }}}
"""}}}
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
""" Keybindings {{{

"Make cursor recognize wrapped lines
map <Down> gj
map <Up> gk
map k gk
map j gj

" Quit buffer
nmap <leader>q :q<CR>
nmap <leader>qa :qa<CR>
" Quick save mapping
nmap <leader>, :w<CR>
nmap <leader>,q :wq<CR>
" Discard Buffer
nmap <leader>d :bd<CR>
" Disable ex mode
noremap Q <NOP>

nmap <leader>gc :Gcommit<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>w :Gwrite<CR>

nmap <leader>rel :call NumberToggle()<cr>

nmap <leader>cs :let @/ = ""<cr>

nmap <leader>v :e ~/.vimrc<cr>
nmap <leader>vr :source ~/.vimrc<cr>

nmap <leader>tt :TestSuite<cr>
nmap <leader>tf :TestFile<cr>

" Split management with CTRL + movement keys
noremap <C-J> :wincmd j<cr>
noremap <C-K> :wincmd k<cr>
noremap <C-L> :wincmd l<cr>
noremap <C-H> :wincmd h<cr>
""" }}}
"call ApplyLocalSettings('.')
