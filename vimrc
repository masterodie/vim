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
    let g:my_vimrc = expand('$HOME/.vim/init.vim')
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
Plug 'patstockwell/vim-monokai-tasty'

" Plugins
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive', { 'on': ['Git'] } | Plug 'tpope/vim-git'
Plug 'w0rp/ale'
Plug 'prabirshrestha/vim-lsp' | Plug 'mattn/vim-lsp-settings' | Plug 'rhysd/vim-lsp-ale'
if has('python3') || has('python')
    Plug 'SirVer/ultisnips'| Plug 'honza/vim-snippets' | Plug 'thomasfaingnaert/vim-lsp-snippets' | Plug 'thomasfaingnaert/vim-lsp-ultisnips'
endif
Plug 'Raimondi/delimitMate', { 'for': ['vue','python','javascript','typescript','html']}
Plug 'tpope/vim-surround', { 'for': ['vue','python','javascript','typescript','html']}
Plug 'tpope/vim-repeat', { 'for': ['vue','python','javascript','typescript','html']}
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'Bookmark']} | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter', { 'for': ['vue','python','javascript','typescript','html']}
Plug 'edkolev/tmuxline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!', 'WhichKeyVisual', 'WhichKeyVisual!'] }

" General
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } | Plug 'lighttiger2505/deoplete-vim-lsp'
Plug 'mhinz/vim-startify'
Plug 'editorconfig/editorconfig-vim'

" Filetype Plugins
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'sukima/xmledit', { 'for': ['html'] }
Plug 'lepture/vim-jinja', {'for': 'jinja'}
Plug 'rdolgushin/gitignore.vim', {'for': 'gitignore'}
Plug 'posva/vim-vue', {'for': 'vue'}
Plug 'mattn/emmet-vim', {'for': ['html', 'vue']}

"""Devicons
Plug 'ryanoasis/vim-devicons'

"""Airline
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
let g:vim_monokai_tasty_italic = 1
silent! colorscheme vim-monokai-tasty


""""""""""""""""""
"" PLUGIN SETTINGS
""""""""""""""""""

" Disable netrw
"let loaded_netrwPlugin = 1

" UltiSnips
let g:UltiSnipsSnippetsDir = g:my_vimdir . "/UltiSnips"
let g:snips_author = "Patrick Neff"
let g:snips_email = "odie86@gmail.com"
let g:snips_github = "https://github.com/masterodie"
let g:ultisnips_python_style = 'sphinx'
let g:ultisnips_python_quoting_style = 'single'
let g:ultisnips_python_triple_quoting_style = 'double'


"" supertab
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" delimitMate
let delimitMate_balance_matchpairs = 1

" nerdtree
let NERDTreeIgnore = ['\.pyc$', '__pycache__$[[dir]]', '\~$', '\.git$']

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
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#lsp#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#trailing_format = '●[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = '○[%s]'

" SimplyFold
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 1

" xmledit
let xml_use_xhtml = 1

"startify
let g:startify_custom_header = ''
function! s:nerdtreeBookmarks()
    let bookmarks = systemlist("cut -d' ' -f 2- ~/.NERDTreeBookmarks")
    let bookmarks = bookmarks[0:-2] " Slices an empty last line
    return map(bookmarks, "{'line': v:val, 'path': v:val}")
endfunction

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction
let g:startify_bookmarks = systemlist("cut -sd' ' -f 2- ~/.NERDTreeBookmarks")

let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': function('s:nerdtreeBookmarks'), 'header': ['   NERDTree Bookmarks']},
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

let g:which_key_use_floating_win = 1
let g:which_key_floating_opts = { 'row': '-10', 'width': '-30', 'height': '+5', 'col': '+15' }
let g:which_key_disable_default_offset = 1
let g:which_key_vertical = 1

let g:which_key_map =  {}

" ale
let g:ale_fix_on_save = 1
let g:ale_completion_autoimport = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'vue': ['eslint', 'prettier'],
\}

""""""""""""""
"" KEYBINDINGS
""""""""""""""

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

nnoremap <leader><leader> :Files<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fs :write<CR>
let g:which_key_map['<space>'] = 'fzf-files'
let g:which_key_map.f = {
      \ 'name' : '+file' ,
      \ 'f': ['Files'   , 'fzf-files']      ,
      \ 's': ['write'   , 'save-file']      ,
      \ }

" Buffers
nnoremap <leader>, :Buffers<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bf :bfirst<CR>
nnoremap <leader>bh :Startify<CR>
nnoremap <leader>bl :blast<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bn :bnext<CR>
let g:which_key_map[','] = 'fzf-buffers'
let g:which_key_map.b = {
      \ 'name': '+buffer' ,
      \ 'd': ['bd'        , 'delete-buffer']   ,
      \ 'f': ['bfirst'    , 'first-buffer']    ,
      \ 'h': ['Startify'  , 'home-buffer']     ,
      \ 'l': ['blast'     , 'last-buffer']     ,
      \ 'n': ['bnext'     , 'next-buffer']     ,
      \ 'p': ['bprevious' , 'previous-buffer'] ,
      \ 'b': ['Buffers'   , 'fzf-buffer']      ,
      \ }

nnoremap <leader>of :NERDTreeToggle<CR>
nnoremap <leader>oh :Startify<CR>
let g:which_key_map.o = {
      \ 'name': '+open' ,
      \ 'f': ['NERDTreeToggle', 'nerdtree-toggle'] ,
      \ 'h': ['Startify'   , 'save-file']      ,
      \ }


nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git<space>commit<CR>
nnoremap <leader>gl :Git<space>log<CR>
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 's': ['Git', 'git-status'] ,
      \ 'c': ['Git commit', 'git-commit'] ,
      \ 'l': ['Git log', 'git-log'] ,
      \ }

nnoremap <leader>qq :q<CR>
nnoremap <leader>qQ :q!<CR>
let g:which_key_map.q = {
      \ 'name': '+quit' ,
      \ 'q': ['quit', 'quit'] ,
      \ 'Q': ['quit!', 'force-quit'] ,
      \ }

nnoremap <leader>hhp :PlugUpdate<CR>
nnoremap <leader>hhP :PlugUpgrade<CR>
nnoremap <leader>hhc :PlugClean<CR>
nnoremap <leader>hhs :PlugStatus<CR>
let g:which_key_map.h = {
      \ 'name': '+help' ,
      \ }

let g:which_key_map.h.p = {
      \ 'name': '+plugin' ,
      \ 'u': ['PlugUpdate', 'plug-update'] ,
      \ 'U': ['PlugUpgrade', 'plug-upgrade'] ,
      \ 'c': ['PlugClean', 'plug-clean'] ,
      \ 's': ['PlugStatus', 'plug-status'] ,
      \ }

nnoremap <leader>ww :Windows<CR>
nnoremap <leader>wc <C-W>c
nnoremap <leader>ws <C-W>s
nnoremap <leader>wh <C-W>h
nnoremap <leader>wj <C-W>j
nnoremap <leader>wk <C-W>k
nnoremap <leader>wl <C-W>l
nnoremap <leader>wd <C-W>c
let g:which_key_map.w = {
      \ 'name': '+window' ,
      \ 'w': ['<C-W>w'     , 'fzf-windows']          ,
      \ 'd': ['<C-W>c'     , 'delete-window']         ,
      \ 'h': ['<C-W>h'     , 'window-left']           ,
      \ 'j': ['<C-W>j'     , 'window-below']          ,
      \ 'l': ['<C-W>l'     , 'window-right']          ,
      \ 'k': ['<C-W>k'     , 'window-up']             ,
      \ 's': ['<C-W>s'     , 'split-window-below']    ,
      \ 'v': ['<C-W>v'     , 'split-window-below']    ,
      \ }

nnoremap <leader>pf :NERDTreeToggle<CR>
nnoremap <leader>pB :Bookmark<CR>
let g:which_key_map.p = {
      \ 'name': '+project' ,
      \ 'f': ['NERDTreeToggle', 'nerdtree-toggle'] ,
      \ 'B': ['Bookmark', 'nerdtree-bookmark'] ,
      \ }

autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')

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
