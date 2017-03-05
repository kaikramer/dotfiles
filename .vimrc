set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tomasr/molokai'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Put your non-Plugin stuff after this line

set ttytype=xterm-256color
set t_Co=256
colorscheme molokai
set background=dark
let g:rehash256 = 1
highlight DiffText cterm=none ctermfg=black ctermbg=Red

hi StatusLine term=reverse  cterm=reverse  gui=reverse
set ls=2 " Always show status line
if has("statusline")
  set statusline=\ %F%m%r%h%w\ \ %y\ [%{&ff}]\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}\ Tabstop:\ %{&ts}\ \ Shiftwidth:\ %{&shiftwidth}%=\ Line:\ %l/%L\ \ C
endif

set fencs=utf-8,latin1
set digraph ek hidden sc vb
set showmode
set ignorecase
set noerrorbells
set noexpandtab
set nostartofline
set nowrap
set textwidth=0
set wildmenu
set formatoptions=cqrt
set shortmess=atToO
set whichwrap=<,>,h,l
set comments=b:#,:%,fb:-,n:>,n:),sl:/**,mb:\ *,elx:\ */
set viminfo=%,'50,\"100,:100,n~/.viminfo
set t_vb=
set hls
set incsearch
map <BS> X
filetype plugin on
filetype indent on
set backspace=indent,eol,start
set ruler
set showcmd
syntax on
set foldmethod=indent
set foldnestmax=3
set nofoldenable
set foldlevel=1
nnoremap <tab> za
set nolist
set listchars=tab:>.,trail:~
set tabstop=4
set shiftwidth=4
cmap w!! w !sudo tee % >/dev/null  " w!! let's you sudo after file was opened!
set autowrite
map <F11> :make<CR>

autocmd Filetype c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" make yank/paste use the global system clipboard
set clipboard=unnamed

let mapleader=","
set history=500
set undolevels=500
set ttimeoutlen=50

nmap <C-b> :bp<cr>
nmap <C-n> :bn<cr>
nmap <C-t> :enew<cr>
nmap <C-w> :bp <BAR> bd #<CR>

" jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif

"""""""""""""""""""""""""""""""
" airline
"""""""""""""""""""""""""""""""
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_iminsert=0
" determine whether inactive windows should have the left section collapsed to only the filename of that buffer.
let g:airline_inactive_collapse=1
" defines whether the preview window should be excluded from have its window statusline modified
" (may help with plugins which use the preview window heavily)
let g:airline_exclude_preview = 0
let g:airline_theme             = 'powerlineish'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'
" (mode, paste, iminsert)
"let g:airline_section_a
" (hunks, branch)
"let g:airline_section_b
" (bufferline or filename)
"let g:airline_section_c
" (readonly, csv)
"let g:airline_section_gutter
" (tagbar, filetype, virtualenv)
let g:airline_section_x="%y \ ts:\ %{&ts}\ \ sw:\ %{&shiftwidth}"
" (fileencoding, fileformat)
"let g:airline_section_y
" (percentage, line number, column number)
"let g:airline_section_z
" (syntastic, whitespace)
"let g:airline_section_warning

let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = 'RO'
let g:airline_symbols.linenr = 'LN'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'

"""""""""""""""""""""""""""""""
" ctrlp
"""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_show_hidden = 1
" When invoked, unless a starting directory is specified, CtrlP will set its
" local working directory according to this variable: 
" 'c' - the directory of the current file.
" 'r' - the nearest ancestor that contains one of these directories or files:
" .git .hg .svn .bzr _darcs, and your own root markers defined with the
" g:ctrlp_root_markers option.
" 'a' - like 'c', but only applies when the current working directory outside
" of CtrlP isn't a direct ancestor of the directory of the current file.
" 0 or '' (empty string) - disable this feature. 
let g:ctrlp_working_path_mode = 'ra'

