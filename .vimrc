set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Put your non-Plugin stuff after this line

" colors
syntax on
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

set fencs=utf-8,latin1          " auto detection of file encoding
set esckeys                     " when this option is off, the cursor and function keys cannot be used in Insert mode if they start with an <Esc> 
set visualbell                  " flash screen, no beeping
set t_vb=                       " no flash
set noerrorbells                " don't ring bell for error messages
set nojoinspaces                " insert only one space after sentences when joining lines
set whichwrap=<,>,h,l,b         " allow specified keys that move the cursor left/right to move to the previous/next line
set backspace=indent,eol,start  " backspace deletes like most programs
map <BS> X                      " make backspace delete the character in front of the cursor
set ruler                       " show the cursor position all the time
set autowrite                   " automatically :write before running commands
set showcmd                     " display incomplete commands
set showmode                    " if in Insert, Replace or Visual mode put a message on the last line
set nostartofline               " don't goto start of line with some commands
set nowrap                      " don't wrap long lines
set textwidth=0                 " no max line width
set wildmenu                    " enhanced command-line completion
set formatoptions=cqrt          " format options: c = auto-wrap comments, q = allow formatting comments with gq, r = auto-insert comment leader, t = auto-wrap text
set shortmess=atToO             " no shortening of messages
set comments=b:#,:%,fb:-,n:>,n:),sl:/**,mb:\ *,elx:\ */
set viminfo=%,'50,\"100,:100,n~/.viminfo

" line numbers
"set relativenumber
set number
set numberwidth=5

" searching
set hlsearch
set incsearch
set ignorecase

" folding
set foldmethod=indent
set foldnestmax=3
set nofoldenable
set foldlevel=1
nnoremap <tab> za

" show white space?
set list
set listchars=tab:».,trail:.

" tabs
set expandtab                   " use the appropriate number of spaces to insert a tab (Ctrl-V<tab> inserts real tab)
set smarttab                    " smart tab and backspace
set shiftround                  " round indent to multiple of 'shiftwidth'
set tabstop=4
set shiftwidth=4

autocmd Filetype c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" make yank/paste use the global system clipboard
set clipboard=unnamed

let mapleader=","

set history=100
set undolevels=200
set ttimeoutlen=50

nmap <C-b> :bp<cr>
nmap <C-n> :bn<cr>
nmap <leader>bn :enew<cr>
nmap <leader>bc :bp <BAR> bd #<cr>

map <F2> :NERDTreeToggle<CR>
map <F11> :make<CR>
cmap w!! w !sudo tee % >/dev/null  " w!! let's you sudo after file was opened!

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


" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag --literal --files-with-matches --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif
