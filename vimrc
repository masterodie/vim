"""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" VIM Config - by odie
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python'

""""""""""""
"" FUNCTIONS
""""""""""""

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Recursively search up from dirname, sourcing all .vimrc.local files along the way
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

" Toggle relative number
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction

" Delete Trailing Whitespace
function! DeleteTrailingWS()
    if ! &bin
        silent! %s/\s\+$//ge
    endif
endfunction

"Restore Last Cursor Position
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

""""""""""
"" PLUGINS
""""""""""

" Install Vim Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

let path='~/.vim/bundle'
if has('win32')
    let path='~/vimfiles/bundle'
endif
call plug#begin(path)

" Colorschemes
"Plug 'altercation/vim-colors-solarized'
"Plug 'jnurmine/Zenburn'
"Plug 'sickill/vim-monokai'
"Plug '29decibel/codeschool-vim-theme'
Plug 'tomasr/molokai'

" Plugins
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdtree'
Plug 'thisivan/vim-bufexplorer'
Plug 'kien/ctrlp.vim', {'on': ['CtrlP','CtrlPMixed','CtrlPBuffer']}
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'xolox/vim-misc'
Plug 'rkitover/vimpager'
Plug 'Konfekt/FastFold'


" Filetype Plugins
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'jmcantrell/vim-virtualenv'
"Plug 'python-rope/ropevim', {'for': 'python'}
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
Plug 'hdima/python-syntax'
Plug 'tmhedberg/SimpylFold', {'for': 'python'}
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'hallettj/jslint.vim', {'for': 'javascript'}
Plug 'nono/jquery.vim', {'for': 'javascript'}
Plug 'xolox/vim-lua-ftplugin', {'for': ['lua']}
Plug 'sukima/xmledit', {'for': ['html', 'xml', 'jinja', 'php']}
Plug 'othree/xml.vim', {'for': ['html', 'xml', 'jinja', 'php']}
Plug 'lepture/vim-jinja', {'for': 'jinja'}
Plug 'groenewege/vim-less', {'for': 'less'}
Plug 'vim-scripts/po.vim', {'for': 'po'}
Plug 'vim-scripts/po.vim--gray', {'for': 'po'}
Plug 'rdolgushin/gitignore.vim', {'for': 'gitignore'}
Plug 'mustache/vim-mustache-handlebars'
Plug 'masterodie/vim-poe-filter-syntax'
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'shawncplus/phpcomplete.vim', {'for': 'php'}
Plug 'dsawardekar/wordpress.vim'
Plug 'jaredly/vim-debug'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Quramy/tsuquyomi', {'for': 'typescript'}
Plug 'leafgarland/typescript-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'bdauria/angular-cli.vim'

"Plug 'godlygeek/tabular'
"Plug 'Rykka/riv.vim'
Plug 'janko-m/vim-test'
"Plug 'sickill/vim-pasta'
"Plug 'pearofducks/ansible-vim'
Plug 'benmills/vimux'

Plug 'Shougo/neocomplete.vim', Cond(!has('nvim'))
Plug 'davidhalter/jedi-vim', Cond(!has('nvim'), { 'for': 'python' })
Plug 'Shougo/deoplete.nvim', Cond(has('nvim'), { 'do': ':UpdateRemotePlugins' })
Plug 'zchee/deoplete-jedi', Cond(has('nvim'), { 'for': 'python' })
"Plug 'ternjs/tern_for_vim', Cond(has('nvim'), { 'do': 'npm install' })
"Plug 'carlitux/deoplete-ternjs', Cond(has('nvim'))
Plug 'mhartington/nvim-typescript', Cond(has('nvim'))
Plug 'othree/javascript-libraries-syntax.vim'

call plug#end()            " required
syntax on
filetype plugin on
filetype indent on

"""""""""""""""
"" VIM SETTINGS
"""""""""""""""

" Enable UTF-8 Mode
scriptencoding utf-8
" Set to Vim Mode
set nocompatible

" Load windows Environment
if has('win32')
    source $VIMRUNTIME/mswin.vim
endif

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

" Paste mode toggle key
set pastetoggle=<F11>

" Set Leader Key
let g:mapleader = ","
let g:maplocalleader = ";"

"" Mouse Settings
if has('mouse')
    set mouse=a
    "set ttymouse=xterm2
    "Mouse select
    set selectmode=mouse
endif

"" Search Settings
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

"" Misc Settings
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
" Backup, tag and undo locations
if has("win32")
    set backupdir=~/vimfiles/backup
    set directory=~/vimfiles/tmp
    set tags=./.tags,~/vimfiles/tags,tags
    set undodir=~/vimfiles/undo
else
    set tags=./.tags,~/.vim/tags,tags
    set backupdir=~/.vim/backup
    set directory=~/.vim/tmp
    set undodir=~/.vim/undo
endif
" Enable persistent undo
if has("persistent_undo")
    set undofile
endif
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
" GUI Settings
if has("gui_running")
    "" Gui Font
    if has("gui_gtk2")
        set guifont=Terminess\ Powerline\ 8
        set guioptions=eg
        set antialias
    elseif has("gui_macvim")
        set guifont=Terminus\ (TTF):h16
        set noantialias
    elseif has("gui_win32")
        set guifont=Terminus\ \(TTF\)\ for\ Windows:h12
        set guioptions=eg
        set antialias
    endif
    "" Antialiasing on
endif
" Colorscheme
set t_Co=256
colorscheme molokai
set background=dark
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
"call togglebg#map("<F7>")
if has('nvim')
  set termguicolors
endif


""""""""""""""""""
"" PLUGIN SETTINGS
""""""""""""""""""

" UltiSnips
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
let g:snips_author = "Patrick Neff"
let g:snips_email = "odie86@gmail.com"
let g:snips_github = "https://github.com/masterodie"
let g:ultisnips_python_style = 'sphinx'
let g:ultisnips_python_quoting_style = 'single'
let g:ultisnips_python_triple_quoting_style = 'double'

" Completion
" neocomplete (for vim)
if !has('nvim')
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
"let g:neocomplete#enable_auto_select=0
endif

" deoplete (for nvim)
if has('nvim')
"if !exists('g:deoplete#force_omni_input_patterns')
        "let g:deoplete#force_omni_input_patterns = {}
"endif
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
"let g:deoplete#sources#syntax#min_keyword_length 
"let g:deoplete#lock_buffer_name_pattern = '\*ku\*'
"let g:deoplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
"let g:deoplete#enable_auto_select=0

" deoplete-jedi

let g:deoplete#sources#jedi#statement_length = 50
let g:deoplete#sources#jedi#enable_cache = 1 
let g:deoplete#sources#jedi#show_docstring = 1
"let g:deoplete#sources#jedi#python_path
"let g:deoplete#sources#jedi#debug_server
"let g:deoplete#sources#jedi#extra_path
endif
"
" supertab
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
"let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
"let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" delimitMate
"let delimitMate_matchpairs = '(:),[:],{:},<:>'
let delimitMate_balance_matchpairs = 1

" vim-surround

" nerdtree
let NERDTreeIgnore = ['\.pyc$', '__pycache__$[[dir]]', '\~$']
nnoremap <F3>  :NERDTreeToggle<CR>

" ctrlp.vim
noremap <leader>m <Esc>:CtrlP<CR>
noremap <leader>p <Esc>:CtrlPBuffer<CR>
noremap <leader>o <Esc>:CtrlPMixed<CR>

" syntastic
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_aggregate_errors = 1
let g:syntastic_loc_list_height = 4
" Syntastic settings for phpcs and WordPress coding standards
"
" Run base PHP checker first, then run phpcs with WordPress standard
" If phpcs does not exist or the standard does not exist,
" Syntastic skips them (failing gracefully)
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_php_phpcs_args = '--standard=WordPress'

" If phpcs.xml is found, it supercedes the standard set above
let g:syntastic_php_phpcs_standard_file = "phpcs.xml"

let g:syntastic_typescript_checkers = ['tsuquyomi']

" riv.vim
let g:riv_ignored_imaps = "<Tab>,<S-Tab>"

" vim-airline
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

" vim-easytags
"let g:easytags_cmd = '/usr/local/bin/ctags'
let g:easytags_dynamic_files = 2
set tags+=$VIRTUAL_ENV/.tags

" tagbar
let g:tagbar_iconchars = ['▸', '▾']

" vim-virtualenv
let g:virtualenv_auto_activate = 1

" jedi-vim
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
"let g:jedi#smart_auto_mappings = 1
"let g:jedi#show_call_signatures = 1
"let g:jedi#force_py_version = 3

" ropevim
let ropevim_vim_completion = 0
let ropevim_extended_complete = 0
let ropevim_enable_autoimport = 1
let g:ropevim_autoimport_modules = ['os', 'shutil', 'datetime', 'flask.*']
" python-syntax
let python_highlight_all = 1

" SimplyFold
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 1
" vim-javascript

" xmledit
let xml_use_xhtml = 1

" po.vim
let g:po_translator = "Patrick Neff <odie86@gmail.com>"
let g:po_lang_team = "myself"


" vim-test
" make test commands execute using dispatch.vim
let test#strategy = "vimux"
let g:test#preserve_screen = 1

"vim-pasta
let g:pasta_enabled_filetypes = ['python', 'ruby', 'javascript', 'css', 'c', 'sh']

"vimpager
let g:vimpager = {}
let g:less = {}
let g:vimpager.less = 0

let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

let g:deoplete#sources#tss#javascript_support = 1
let g:tsuquyomi_javascript_support = 1
let g:tsuquyomi_auto_open = 1
let g:tsuquyomi_disable_quickfix = 1

""""""""""""""
"" KEYBINDINGS
""""""""""""""

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

nmap <leader>cl :let @/ = ""<cr>

nmap <leader>v :e ~/.vimrc<cr>
nmap <leader>vr :source ~/.vimrc<cr>


nmap <leader>tt :VimuxRunCommand('clear; ' . testrunner)<cr>
nmap <leader>tf :VimuxRunCommand('clear; ' . testrunner . ' ' . bufname('%'))<cr>
nmap <Leader>tz :VimuxZoomRunner<cr>


nmap <leader>l :lnext!<CR>
nmap <leader>L :lprevious!<CR>


" Split management with CTRL + movement keys
if has('nvim')
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    tnoremap <ESC><ESC> <C-\><C-n> 
endif
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" tagbar
nnoremap <F4>  :TagbarToggle<CR>

" vim-easytags
map <S-F11> :!ctags -R -f $VIRTUAL_ENV/.tags $VIRTUAL_ENV/lib/python3.5/site-packages<CT>

if exists('g:vimpager.enabled') && g:vimpager.enabled == 1
    if exists('g:less.enabled')
        unmap k
        unmap j
    endif
endif

""""""""""""""""""""
"" AUTOCOMMAND GROUP
""""""""""""""""""""

augroup vimrc
    autocmd!
    autocmd BufWritePost ~/.vimrc :source ~/.vimrc
    autocmd BufWritePost ~/.vim/vimrc :source ~/.vimrc
    autocmd BufWritePost * :call DeleteTrailingWS()
    autocmd BufWinEnter * call ResCur()
    autocmd FileType jinja let b:surround_45 = "{{ \r }}"
    autocmd FileType jinja let b:surround_95 = "{% \r %}"
    autocmd FileType python let b:surround_45 = "_(\r)"
    if has('nvim')
    else
        "autocmd FileType python setlocal omnifunc=jedi#completions
        "autocmd FileType python setlocal completefunc=jedi#completions
    endif
    "autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html let delimitMate_matchpairs = '(:),[:],{:}'
    autocmd FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
    autocmd FileType python let b:delimitMate_expand_cr = 1
    autocmd FileType python let b:delimitMate_expand_inside_quotes = 1
    autocmd FileType typescript,html,jinja,jinja2 call angular_cli#init()
augroup END

" Aplly local settings
call ApplyLocalSettings('.')
