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

if has('nvim')
    "let g:my_vimdir = expand('$HOME/.config/nvim')
    let g:my_vimdir = expand('$HOME/.vim')
    let g:my_vimrc = g:my_vimdir . '/init.vim'
else
    let g:my_vimdir = expand('$HOME/.vim')
    let g:my_vimrc = expand('$HOME/.vimrc')
endif
let g:my_plugdir = g:my_vimdir . '/bundle'
let g:my_plug = g:my_vimdir . '/autoload/plug.vim'

""""""""""
"" PLUGINS
""""""""""

" Install Vim Plug if not installed
if empty(glob(g:my_plug))
  execute 'silent !curl -fLo ' . g:my_plug . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall
endif

call plug#begin(g:my_plugdir)

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
Plug 'edkolev/tmuxline.vim'
"Plug 'rkitover/vimpager'
Plug 'junegunn/fzf.vim'

" General
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi', { 'for': 'python', 'do': 'git submodule update' }
"Plug 'neomake/neomake'
Plug 'mhinz/vim-startify'
Plug 'editorconfig/editorconfig-vim'
Plug 'majutsushi/tagbar'
Plug 'carlitux/deoplete-ternjs'
Plug 'vim-syntastic/syntastic'

" Filetype Plugins
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
Plug 'hdima/python-syntax'
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'sukima/xmledit'
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
"Plug 'Quramy/tsuquyomi'
"Plug 'Quramy/tsuquyomi-vue'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'HerringtonDarkholme/yats.vim'

"""Devicons
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()            " required

"""""""""""""""
"" VIM SETTINGS
"""""""""""""""

syntax on
filetype plugin indent on
scriptencoding utf-8

"Move over end of line
set whichwrap=b,s,<,>,[,],h,l
" Backspace over autoindent, line breaks, start of insert (see :help 'backspace')
set backspace=indent,eol,start
"Auto indentation
set autoindent
"Tabs
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Paste mode toggle key
set pastetoggle=<F11>

" Set Leader Key
let g:mapleader = ","
let g:maplocalleader = ";"

"" Mouse Settings
if has('mouse')
    set mouse=a
    set selectmode=mouse
endif

"" Search Settings
"Better Tab Completion
set wildmenu
set wildmode=list:longest
set hlsearch
set ignorecase
set smartcase
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
execute 'set tags=./.tags,' . g:my_vimdir . '/tags,tags'
execute 'set backupdir=' . g:my_vimdir . '/backup'
execute 'set directory=' . g:my_vimdir . '/tmp'
execute 'set undodir=' . g:my_vimdir . '/undo'
" Line numbers
set number
" Make bell visual and disable error bells
set visualbell
set noerrorbells
" Show (partial) command in status line
set showcmd
" Colorize column 80
set colorcolumn=80
"
" Enable persistent undo
if has("persistent_undo")
    set undofile
endif

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
    endif
    "" Antialiasing on
endif
"
" Faster redrawing
if !has('nvim')
    set ttyfast
endif

" Colorscheme
"set t_Co=256
let g:my_theme="molokai"
let g:my_themedir=g:my_plugdir . '/' . g:my_theme . '/colors/' . g:my_theme . '.vim'
if !empty(glob(g:my_themedir))
    execute 'colorscheme ' . g:my_theme
endif
set background=dark
if has('nvim')
  set termguicolors
endif

""""""""""""""""""
"" PLUGIN SETTINGS
""""""""""""""""""

" Disable netrw
let loaded_netrwPlugin = 1

" UltiSnips
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsSnippetsDir = g:my_vimdir . "/UltiSnips"
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
try
    call neomake#configure#automake('nw', 1000)
catch
finally
endtry

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

"syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['eslint']

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

execute 'noremap <leader>v :e ' . g:my_vimrc . '<cr>'
execute 'noremap <leader>vr :source ' . g:my_vimrc . '<cr>'

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
        "autocmd BufWinEnter * :AirlineRefresh
        autocmd BufWinEnter * call myfuncs#RestoreCursor()
        autocmd BufWritePost * :call myfuncs#DeleteTrailingWhitespace()
        execute 'autocmd BufWritePost .vimrc :source' . g:my_vimrc
        execute 'autocmd BufWritePost vimrc :source' . g:my_vimrc
        execute 'autocmd BufWritePost init.vim :source' . g:my_vimrc
    augroup END
endif

call myfuncs#ApplyLocalSettings('.')
