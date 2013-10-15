set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set fileformats=unix
set encoding=utf8
set laststatus=2                " always show statusline "
set nocompatible
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=1
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set incsearch                   " do incremental searching
set nobackup
set shiftwidth=4                " autoindent witespace width      
set uc=0                        " do not use swap file when editing
set nu                          " show line number "
set expandtab                   " expand TAB to white space "

filetype plugin on

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set t_Co=256
endif

if has("autocmd")
  filetype plugin indent on
  autocmd FileType text setlocal tabstop=4
  autocmd FileType text setlocal textwidth=78
  autocmd FileType html setlocal shiftwidth=2
  autocmd FileType xml setlocal shiftwidth=2
  augroup json_autocmd
   autocmd!
   autocmd FileType json set autoindent
   autocmd FileType json set formatoptions=tcq2l 
   autocmd FileType json set textwidth=78 shiftwidth=2
   autocmd FileType json set softtabstop=2 tabstop=8
   autocmd FileType json set expandtab
   autocmd FileType json set foldmethod=syntax
else
  set autoindent        " always set autoindenting on
endif

colorscheme calmar256-dark

"""""""""""""""""""""""""""
" settings for taglist
"""""""""""""""""""""""""""
nnoremap <silent> <F5> :TlistToggle<CR>
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window=1

"""""""""""""""""""""""""""
" netrwin 
"""""""""""""""""""""""""""
let g:netrw_winsize = 30

""""""""""""""""""""""""""""
" winManager  setting
""""""""""""""""""""""""""""
let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
let g:winManagerWidth = 30
"let g:defaultExplorer = 1

nmap <C-W><C-F>  :FirstExplorerWindow<cr>
nmap <C-W><C-B>  :BottomExplorerWindow<CR>
nmap <silent> <leader>wm :WMToggle<CR>

""""""""""""""""""""""""""""
" Mojolicious
" https://github.com/yko/mojo.vim
"""""""""""""""""""""""""""
let mojo_highlight_data = 1
let mojo_disable_html = 0
let mojo_no_helpers = 0

"""""""""""""""""""""""""""""
" Jekyll
"""""""""""""""""""""""""""""
function Jekyll_AddTitle()
    call setline(1,"---")
    call append(1,"layout: post")
    call append(2,"title: title")
    call append(3,"category: category")
    call append(4,"change_frequency: monthly")
    call append(5,"---")
endfunc

map <leader>jt :call Jekyll_AddTitle()<CR>

"""""""""""""""""""""""""""""
" Auto insert file title
"""""""""""""""""""""""""""""
function AddTitle(cmt_start,cmt_end,cmt)
    if a:cmt_start == a:cmt
        call setline(1,repeat(a:cmt,60))
    else
        call setline(1,a:cmt_start.repeat(a:cmt,60))
    endif
    call append(1,a:cmt."Author    : ChinaXing - chen.yack@gmail.com")
    call append(2,a:cmt."Create    : ".strftime("%Y-%m-%d %H:%M"))
    call append(3,a:cmt."Function  : xxxxx")
    if a:cmt_end == a:cmt
        call append(4,repeat(a:cmt,60))
    else
        call append(4,repeat(a:cmt,60).a:cmt_end)
    endif
endfunc

function AddTitle_for_file()
    if &filetype == "sh" || &filetype == "bash" 
                \ || &filetype == "perl" || &filetype == "python"
        let s:cmt_start = '#'
        let s:cmt = '#' 
        let s:cmt_end = '#'
    elseif &filetype == "c" || &filetype == "cpp" || &filetype == "javascript"
        let s:cmt_start = '/' 
        let s:cmt = '*' 
        let s:cmt_end = '/'
    elseif &filetype == "vim"
        let s:cmt_start = '"' 
        let s:cmt = '"' 
        let s:cmt_end = '"'
    else
        return 
    endif
    call AddTitle(s:cmt_start,s:cmt_end,s:cmt)
endfunc

map <leader>at :call AddTitle_for_file()<CR>

