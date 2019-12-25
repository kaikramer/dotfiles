" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" colors
syntax on
set ttytype=xterm-256color
set t_Co=256
colorscheme onehalfdark
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
let g:gruvbox_contrast_dark='hard'
set background=dark
let g:rehash256=1
highlight DiffText cterm=none ctermfg=black ctermbg=Red

" workaround for compatibility problem with Windows Terminal, see https://github.com/microsoft/terminal/issues/832
set t_ut=""

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
let g:airline_theme             = 'onehalfdark'
"let g:airline_theme             = 'powerlineish'
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
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = 'RO'
"let g:airline_symbols.linenr = 'LN'
"let g:airline#extensions#tabline#left_sep = ''
"let g:airline#extensions#tabline#left_alt_sep = '|'

"""""""""""""""""""""""""""""""
" fzf
"""""""""""""""""""""""""""""""

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
"let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
"let $FZF_DEFAULT_OPTS="--preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null'"
"let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" Launch fzf with CTRL+P.
nnoremap <silent> <C-p> :FZF -m<CR>

" Map a few common things to do with FZF.
nnoremap <silent> <Leader>r :Rg<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>
nnoremap <silent> <Leader>c :Commits<CR>
nnoremap <silent> <Leader>o :Colors<CR>

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
"let g:fzf_layout = { 'window': 'enew' }
"let g:fzf_layout = { 'window': '-tabnew' }
"let g:fzf_layout = { 'window': '10new' }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'
