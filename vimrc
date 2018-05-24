"""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" VIM Config - by odie
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
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
        exec ':runtime' . l:settingsFile
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

" Aplly local settings
source $HOME/.vimrc.local

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
Plug 'tomasr/molokai'

" Plugins
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
if has('python3') || has('python')
    Plug 'SirVer/ultisnips'| Plug 'honza/vim-snippets'
endif
Plug 'ervandew/supertab'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'thisivan/vim-bufexplorer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'bling/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'rkitover/vimpager'

if exists("g:pluginsHuge")
    " General
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'zchee/deoplete-jedi', { 'for': 'python', 'do': 'git submodule update' }
    Plug 'neomake/neomake'
    Plug 'mhinz/vim-startify'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'majutsushi/tagbar'
    Plug 'carlitux/deoplete-ternjs'

    " Filetype Plugins
    Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
    Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
    Plug 'hdima/python-syntax'
    Plug 'pangloss/vim-javascript', {'for': 'javascript'}
    Plug 'sukima/xmledit', { 'do': 'make' }
    Plug 'lepture/vim-jinja', {'for': 'jinja'}
    Plug 'vim-scripts/po.vim', {'for': 'po'}
    Plug 'vim-scripts/po.vim--gray', {'for': 'po'}
    Plug 'rdolgushin/gitignore.vim', {'for': 'gitignore'}
    Plug 'masterodie/vim-poe-filter-syntax'
    Plug 'StanAngeloff/php.vim', {'for': 'php'}
    Plug 'shawncplus/phpcomplete.vim', {'for': 'php'}
    Plug 'dsawardekar/wordpress.vim'
    Plug 'f-breidenstein/icinga-vim'
    Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
    Plug 'posva/vim-vue'

    """Devicons
    Plug 'ryanoasis/vim-devicons'
endif

call plug#end()            " required
syntax on
filetype plugin on
filetype indent on

"""""""""""""""
"" VIM SETTINGS
"""""""""""""""

" Enable UTF-8 Mode
scriptencoding utf-8

" Load windows Environment
if has('win32')
    source $VIMRUNTIME/mswin.vim
endif

"Move over end of line
set whichwrap=b,s,<,>,[,],h,l
" Backspace over autoindent, line breaks, start of insert (see :help 'backspace')
set backspace=indent,eol,start
"Auto indentation
set autoindent
"Smart tab
set smarttab
"Tab Width
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

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
"Use "./" in the 'tags' options reads tags file relative to current directory
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
set noerrorbells
" Show (partial) command in status line
set showcmd
" Faster redrawing
if !has('nvim')
    set ttyfast
endif
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
if has('win32')
let g:theme="~/vimfiles/bundle/molokai/colors/molokai.vim"
else
let g:theme="~/.vim/bundle/molokai/colors/molokai.vim"
endif
if !empty(glob(g:theme))
    colorscheme molokai
endif
set background=dark
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

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" deoplete-jedi
let g:deoplete#sources#jedi#statement_length = 50
let g:deoplete#sources#jedi#enable_cache = 1
let g:deoplete#sources#jedi#show_docstring = 1
"
" supertab
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" delimitMate
let delimitMate_balance_matchpairs = 1

" nerdtree
let NERDTreeIgnore = ['\.pyc$', '__pycache__$[[dir]]', '\~$']
nnoremap <F3>  :NERDTreeToggle<CR>
nnoremap <leader>f  :NERDTreeToggle<CR>

" ctrlp.vim
noremap <leader>m <Esc>:CtrlP<CR>
noremap <leader>p <Esc>:CtrlPBuffer<CR>
noremap <leader>o <Esc>:CtrlPMixed<CR>

"neomake
call neomake#configure#automake('nw', 1000)
let g:neomake_error_sign = {'text': '✖', 'texthl': 'ErrorMsg'}
let g:neomake_warning_sign = {'text': '⚠', 'texthl': 'WarningMsg'}
let g:neomake_open_list = 2
let g:neomake_airline = 1
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_javascript_enabled_makers = ['eslint_d']
let g:neomake_vue_enabled_makers = ['eslint_d']
let g:neomake_vue_eslint_d_args = ['--format=compact']

" vim-devicons
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:webdevicons_enable_ctrlp = 1

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme = "molokai"
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#whitespace#trailing_format = '●[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = '○[%s]'

" tagbar
let g:tagbar_iconchars = ['▸', '▾']

" SimplyFold
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 1

" xmledit
let xml_use_xhtml = 1

" po.vim
let g:po_translator = "Patrick Neff <odie86@gmail.com>"
let g:po_lang_team = "myself"

"vimpager
let g:vimpager = {}
let g:less = {}
let g:vimpager.less = 0

"startify
let g:startify_custom_header = ''
function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

"tern
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '1'
let g:tern#filetypes = ['jsx', 'javascript.jsx', 'vue', 'javascript']

""""""""""""""
"" KEYBINDINGS
""""""""""""""

"Make cursor recognize wrapped lines
noremap <Down> gj
noremap <Up> gk
noremap k gk
noremap j gj

" Quit buffer
noremap <leader>q :q<CR>
noremap <leader>qq :q!<CR>
noremap <leader>qa :qa<CR>
" Quick save mapping
noremap <leader>, :w<CR>
noremap <leader>,q :wq<CR>
" Discard Buffer
noremap <leader>d :bd<CR>
" Disable ex mode
noremap Q <NOP>

noremap <leader>gc :Gcommit<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>w :Gwrite<CR>

noremap <leader>rel :call NumberToggle()<cr>

noremap <leader>cl :let @/ = ""<cr>

noremap <leader>v :e ~/.vimrc<cr>
noremap <leader>vr :source ~/.vimrc<cr>

noremap <leader>l :lnext!<CR>
noremap <leader>L :lprevious!<CR>

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
nnoremap <leader>b  :TagbarToggle<CR>

if exists('g:vimpager.enabled') && g:vimpager.enabled == 1
    if exists('g:less.enabled')
        unmap k
        unmap j
    endif
endif

""""""""""""""""""""
"" AUTOCOMMAND GROUP
""""""""""""""""""""

if has('autocmd')
    augroup vimrc
        autocmd!
        autocmd BufWinEnter * :AirlineRefresh
        autocmd BufWinEnter * call ResCur()
        autocmd BufWritePost ~/.vimrc :source ~/.vimrc
        autocmd BufWritePost ~/.vim/vimrc :source ~/.vim/vimrc
        autocmd BufWritePost ~/.config/nvim/init.vim :source ~/.config/nvim/init.vim
        autocmd BufWritePost * :call DeleteTrailingWS()
    augroup END
endif
