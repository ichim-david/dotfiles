call pathogen#runtime_append_all_bundles()
set nocompatible 
silent! call pathogen#helptags()

filetype on            " enables filetype detection
filetype plugin indent on     " enables filetype specific plugins
let mapleader = ","
syntax enable
set t_Co=256
colorscheme twilight
set et
set sw=4 " shiftwidth is the tabs spaces that is indented
set smarttab
set smartindent
set smartcase " match case sensitive if there are uppercase letters
set autoindent
set linespace=3 " make line space bigger
set splitbelow " split windows below current window
set hlsearch " highlight search entry
" For autocompletion
set foldenable "  enable fold support
noremap <F5> <ESC>:w<CR>:execute "!python %"<CR>
set number
set mouse=a
:noremap <C-left> :bprev<CR>
:noremap <C-right> :bnext<CR> 

set laststatus=2
:let g:buftabs_in_statusline=1

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden " switch between buffers without warning that is not saved
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
"set status line to display current position and other things
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)

map ; :
imap ;; <Esc>
set nowrap " no wordwrap

" don't write any temporary files
set nobackup
set nowritebackup
set noswapfile

set showmatch "show matching brackets
set ignorecase "case insensitive matching
set wildignore=*.swp,*.bak,*.pyc,*.class
set textwidth=0 "don't wrap text
set scrolloff=5 "keep context while scrolling
set visualbell           " don't beep
set noerrorbells         " don't beep
autocmd filetype python set expandtab
let python_highlight_all = 1
" Use the ack.pl script on PATH to grep intelligently
" function! Ack(args)
"     let grepprg_bak=&grepprg
"     set grepprg=ack\\ -H\\ --nocolor\\ --nogroup
"     execute "silent! lgrep " . a:args
"     botright lopen
"     let &grepprg=grepprg_bak
" endfunction

" command! -nargs=* -complete=file Ack call Ack(<q-args>)
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" map y p and x to clipboard 
nnoremap y "+y
vnoremap y "+y
nnoremap p "+p
vnoremap p "+p
inoremap <C-P> <Esc>"+p<CR>
nnoremap x "+x
vnoremap x "+x
nnoremap t :CommandT<CR>
nnoremap T :CommandTBuffer<CR>
" nnoremap m :CommandTFlush<CR>
" <Leader>V opens this file (.vimrc)
map <Leader>v :sp ~/.vimrc<CR><C-W>_

" map leader so to reload vim 
nmap <silent> <leader>sv :so ~/.vimrc<CR>

" close files with fc, force close with fq
"nnoremap <Leader>fc <Esc>:call CleanClose(1)<CR>
nnoremap ff <Esc>:call CleanClose(1)<CR>
"nnoremap <Leader>fq <Esc>:call CleanClose(0)<CR>
nnoremap fq <Esc>:call CleanClose(0)<CR>

nnoremap <silent> <C-f> :NERDTreeFind<CR> 
let NERDTreeIgnore = ['\.pyc$', '\~$', '\.svn']
function! CleanClose(tosave)
if (a:tosave == 1)
    w!
endif
let todelbufNr = bufnr("%")
let newbufNr = bufnr("#")
if ((newbufNr != -1) && (newbufNr != todelbufNr) && buflisted(newbufNr))
    exe "b".newbufNr
else
    bnext
endif

if (bufnr("%") == todelbufNr)
    new
endif
exe "bd".todelbufNr
" call Buftabs_show()
endfunction

" hightlight charachters that are over 80 chars in a line
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" paste mode with f2 will not make vim apply indentation when pasting large text
set pastetoggle=<F2>

" window / splits
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" autocomplete for python js html css
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" SuperTab also works with vim's builtin autocomplete feature OmniComplete. 
" Just add following line after your OmniComplete configurations.
let g:SuperTabDefaultCompletionType = "context"

" try to open .dtml as css and zcml as xml
autocmd BufNewFile,BufRead *.dtml             set ft=css
autocmd BufNewFile,BufRead *.zcml             set ft=xml
" finish tag when adding </
iabbrev </c-w>  </<C-X><C-O>

" map auto complete to ctrl + space
inoremap <C-Space> <C-X><C-O>
" try to map () 
" inoremap        (  ()<Left>
" inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
" inoremap {      {}<Left>
" inoremap {<CR>  {<CR>}<Esc>
" inoremap {{     {
" inoremap {}     {}
"imap ' <C-V>'<C-V>'<Left>"
"imap " <C-V>"<C-V>"<Left>"
"imap { <C-V>{<C-V>}<Left>"
"imap ( <C-V>(<C-V>)<Left>"

""" Zope Stuff
au BufNewFile,BufRead *.pt set filetype=html.pt
au BufNewFile,BufRead *.zcml set filetype=xml.zcml

" automatically delete whitespace at EOF when saving file
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

" close tags plugin to close </. only for given files
"autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1

autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako,pt source ~/.vim/bundle/closetag/plugin/closetag.vim
" Tagbar displays the tags of the current file in a sidebar, similar to Taglist, but in a super sexy way - ordered by scope.
let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>
" let g:tagbar_compact=1
let g:tagbar_width=36

" hard wrap parapraph text ( get rid of text on one line )
nnoremap <leader>q gqip

"Shortcut to fold tags with leader (usually \) + ft
nnoremap <leader>ft Vatzf


" More useful command-line completion
" set wildmenu

"Auto-completion menu
" set wildmode=list:longest

"http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
" set completeopt=longest,menuone
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"   \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"   \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" map f4 to run jslint
nmap <F4> :w<CR>:make<CR>:cw<CR>
