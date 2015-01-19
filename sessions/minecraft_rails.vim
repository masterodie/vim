" ~/.dotfiles/vim/sessions/minecraft_rails.vim:
" Vim session script.
" Created by session.vim 2.6.4 on 04 August 2014 at 05:14:49.
" Open this file in Vim and run :source % to restore your session.

set guioptions=egmrL
silent! set guifont=Envy\ Code\ R:h13
if exists('g:syntax_on') != 1 | syntax on | endif
if exists('g:did_load_filetypes') != 1 | filetype on | endif
if exists('g:did_load_ftplugin') != 1 | filetype plugin on | endif
if exists('g:did_indent_on') != 1 | filetype indent on | endif
if &background != 'dark'
	set background=dark
endif
if !exists('g:colors_name') || g:colors_name != 'solarized' | colorscheme solarized | endif
call setqflist([])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Documents/Projects/Ruby/minecraft
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +5 config/routes.rb
badd +0 ~/Documents/Projects/Ruby/minecraft
badd +1 app/assets/stylesheets/google-fonts.css.scss
badd +20 app/views/home/index.html.erb
badd +27 app/views/layouts/application.html.erb
badd +5 app/assets/stylesheets/twbs.css.scss
badd +1 app/assets/stylesheets/chat_messages.css.scss
badd +47 Gemfile
badd +1 Gemfile.lock
badd +9 app/views/posts/show.html.erb
badd +5 app/views/servers/dynmap.html.erb
badd +2 app/views/users/show.html.erb
badd +7 app/views/servers/show.html.erb
badd +11 app/models/user.rb
badd +3 app/models/post.rb
badd +6 app/models/server.rb
badd +1 app/models/server_setting.rb
badd +25 app/views/layouts/_navigation.html.erb
badd +1 app/views/server_settings/new.html.erb
badd +56 app/controllers/server_settings_controller.rb
badd +8 app/controllers/servers_controller.rb
badd +16 app/views/server_settings/_form.html.erb
badd +5 app/views/posts/_form.html.erb
badd +25 app/controllers/posts_controller.rb
badd +34 app/views/layouts/blog.html.erb
badd +7 app/views/layouts/_sidebar.html.erb
badd +5 app/controllers/home_controller.rb
badd +7 app/controllers/application_controller.rb
badd +1 app/controllers/chat_messages_controller.rb
badd +21 .gitignore
badd +6 app/models/gallery.rb
badd +25 app/controllers/galleries_controller.rb
badd +7 app/views/galleries/_form.html.erb
badd +15 app/views/galleries/index.html.erb
badd +32 app/views/galleries/show.html.erb
badd +13 app/models/image.rb
badd +1 app/views/images/new.html.erb
badd +39 app/controllers/images_controller.rb
badd +1 app/views/galleries/new.html.erb
badd +1 app/views/images/_form.html.erb
badd +4 db/migrate/20140803234335_create_images.rb
badd +6 app/controllers/items_controller.rb
badd +6 app/views/images/show.html.erb
badd +25 app/views/images/index.html.erb
badd +1 app/models/inventory.rb
badd +25 app/controllers/players_controller.rb
badd +3 db/migrate/20140804003700_add_image_to_images.rb
badd +3 db/migrate/20140802235913_add_featured_image_to_posts.rb
badd +1 app/views/galleries/index.json.jbuilder
badd +1 app/views/images/new.js.erb
badd +2 app/views/galleries/new.js.erb
badd +3 app/views/galleries/create.js.erb
badd +7 app/views/galleries/_gallery.html.erb
badd +1 app/views/images/create.js.erb
argglobal
silent! argdel *
argadd \[BufExplorer]
edit app/views/galleries/show.html.erb
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 31 + 88) / 177)
exe '2resize ' . ((&lines * 20 + 31) / 63)
exe 'vert 2resize ' . ((&columns * 145 + 88) / 177)
exe '3resize ' . ((&lines * 20 + 31) / 63)
exe 'vert 3resize ' . ((&columns * 145 + 88) / 177)
exe '4resize ' . ((&lines * 19 + 31) / 63)
exe 'vert 4resize ' . ((&columns * 145 + 88) / 177)
argglobal
enew
" file NERD_tree_1
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
lcd ~/Documents/Projects/Ruby/minecraft
wincmd w
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 33 - ((12 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
33
normal! 089|
lcd ~/Documents/Projects/Ruby/minecraft
wincmd w
argglobal
edit ~/Documents/Projects/Ruby/minecraft/app/views/galleries/create.js.erb
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/Documents/Projects/Ruby/minecraft
wincmd w
argglobal
edit ~/Documents/Projects/Ruby/minecraft/app/views/images/new.js.erb
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 2 - ((1 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
2
normal! 046|
lcd ~/Documents/Projects/Ruby/minecraft
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 31 + 88) / 177)
exe '2resize ' . ((&lines * 20 + 31) / 63)
exe 'vert 2resize ' . ((&columns * 145 + 88) / 177)
exe '3resize ' . ((&lines * 20 + 31) / 63)
exe 'vert 3resize ' . ((&columns * 145 + 88) / 177)
exe '4resize ' . ((&lines * 19 + 31) / 63)
exe 'vert 4resize ' . ((&columns * 145 + 88) / 177)
tabnext 1
if exists('s:wipebuf')
"   silent exe 'bwipe ' . s:wipebuf
endif
" unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save

" Support for special windows like quick-fix and plug-in windows.
" Everything down here is generated by vim-session (not supported
" by :mksession out of the box).

1wincmd w
tabnext 1
let s:bufnr_save = bufnr("%")
let s:cwd_save = getcwd()
NERDTree ~/Documents/Projects/Ruby/minecraft
if !getbufvar(s:bufnr_save, '&modified')
  let s:wipebuflines = getbufline(s:bufnr_save, 1, '$')
  if len(s:wipebuflines) <= 1 && empty(get(s:wipebuflines, 0, ''))
    silent execute 'bwipeout' s:bufnr_save
  endif
endif
execute "cd" fnameescape(s:cwd_save)
1resize 61|vert 1resize 31|2resize 20|vert 2resize 145|3resize 20|vert 3resize 145|4resize 19|vert 4resize 145|
2wincmd w
tabnext 1
if exists('s:wipebuf')
  if empty(bufname(s:wipebuf))
if !getbufvar(s:wipebuf, '&modified')
  let s:wipebuflines = getbufline(s:wipebuf, 1, '$')
  if len(s:wipebuflines) <= 1 && empty(get(s:wipebuflines, 0, ''))
    silent execute 'bwipeout' s:wipebuf
  endif
endif
  endif
endif
doautoall SessionLoadPost
unlet SessionLoad
" vim: ft=vim ro nowrap smc=128
