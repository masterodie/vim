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
Plug 'crusoexia/vim-monokai'

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
Plug 'scrooloose/nerdcommenter'
Plug 'edkolev/tmuxline.vim'
"Plug 'rkitover/vimpager'
Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!', 'WhichKeyVisual', 'WhichKeyVisual!'] }
"Plug 'folke/which-key.nvim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'liuchengxu/vim-better-default'

" General
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'zchee/deoplete-jedi', { 'for': 'python', 'do': 'git submodule update' }
Plug 'lighttiger2505/deoplete-vim-lsp'
"Plug 'neomake/neomake'
Plug 'mhinz/vim-startify'
Plug 'editorconfig/editorconfig-vim'
"Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'

" Filetype Plugins
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'hdima/python-syntax'
Plug 'sukima/xmledit'
Plug 'lepture/vim-jinja', {'for': 'jinja'}
Plug 'rdolgushin/gitignore.vim', {'for': 'gitignore'}
Plug 'posva/vim-vue'

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
let g:mapleader = "\<space>"
let g:maplocalleader = ","

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
colorscheme monokai

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
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#trailing_format = '●[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = '○[%s]'

" SimplyFold
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 1

" xmledit
let xml_use_xhtml = 1

"vimpager
let g:vimpager = {}
let g:less = {}
let g:vimpager.less = 0

"startify
let g:startify_custom_header = ''
function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

"syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_eslint_exe = 'npm run eslint --'

"ale
"let g:ale_open_list = 1

let g:which_key_use_floating_win = 1
let g:which_key_floating_relative_win = 1
let g:which_key_floating_opts = { 'row': '-1' }
let g:which_key_disable_default_offset = 1
let g:which_key_centered = 1

let g:which_key_map =  {}

let g:which_key_map.w = {
      \ 'name' : '+window' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }

let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '1' : ['b1'        , 'buffer 1']        ,
      \ '2' : ['b2'        , 'buffer 2']        ,
      \ 'd' : ['bd'        , 'delete-buffer']   ,
      \ 'F' : ['bfirst'    , 'first-buffer']    ,
      \ 'h' : ['Startify'  , 'home-buffer']     ,
      \ 'l' : ['blast'     , 'last-buffer']     ,
      \ 'n' : ['bnext'     , 'next-buffer']     ,
      \ 'p' : ['bprevious' , 'previous-buffer'] ,
      \ 'f' : ['Buffers'   , 'fzf-buffer']      ,
      \ }

let g:which_key_map.f = {
      \ 'name' : '+file' ,
      \ 'f' : ['Files'   , 'fzf-files']      ,
      \ }

let g:which_key_map.s = {
      \ 'name' : '+settings' ,
      \ }

autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')

""""""""""""""
"" KEYBINDINGS
""""""""""""""

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

nnoremap <Leader>, :Buffers<CR>
nnoremap <Leader><Leader> :Files<CR>
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>fr :CtrlPMRU<CR>
nnoremap <C-p> :CtrlP<CR>

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
