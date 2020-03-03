" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-rooter'
Plug 'pearofducks/ansible-vim'
Plug 'liuchengxu/vista.vim'
" color schemes:
Plug 'tomasr/molokai'
Plug 'gruvbox-community/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'chriskempson/base16-vim'
Plug 'ryanoasis/vim-devicons'
call plug#end()

" colors
syntax on
if !has('nvim')
    set ttytype=xterm-256color
endif
set t_Co=256
let g:nord_bold = 0
colorscheme nord
if (has('termguicolors'))
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
"set esckeys                     " when this option is off, the cursor and function keys cannot be used in Insert mode if they start with an <Esc>
set visualbell                  " flash screen, no beeping
set t_vb=                       " no flash
set noerrorbells                " don't ring bell for error messages
set nojoinspaces                " insert only one space after sentences when joining lines
set whichwrap=<,>,h,l,b         " allow specified keys that move the cursor left/right to move to the previous/next line
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
set completeopt=longest,menuone " popup menu doesn't select the first completion item, but inserts the longest common text of all matches; menu will come up even if there's only one match

if !has('nvim')
    set viminfo=%,'50,\"100,:100,n~/.viminfo
endif

" make backspace behave as in most other programs
set backspace=indent,eol,start

" line numbers
set relativenumber
set number
set numberwidth=5
set cursorline

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

let mapleader=","

set ttimeoutlen=50
set history=100

" mouse support
set mouse=a
if !has('nvim')
    if has("mouse_sgr")
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    end
endif

" undo
set undolevels=1000             " How many undos
set undoreload=10000            " number of lines to save for undo
let vimDir = '$HOME/.vim'       " Put plugins and dictionaries in this dir (also on Windows)
let &runtimepath.=','.vimDir
if has('persistent_undo')       " create undo dir if it does not exist
    let myUndoDir = expand(vimDir . '/undo')
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile                    " Save undos after file closes
    set undodir=$HOME/.vim/undo     " where to save undo histories
endif

" shortcuts for switching between buffers
nmap <C-b> :bp<cr>
nmap <C-n> :bn<cr>

map <F11> :make<CR>
cmap w!! w !sudo tee % >/dev/null  " w!! let's you sudo after file was opened!

" jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif

" make yank/paste use the global system clipboard
set clipboard=unnamed

" make 'd' only delete (not yank), and 'leader d' cut (see https://github.com/pazams/d-is-for-delete)
nnoremap x "_x
nnoremap X "_X
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d
nnoremap <BS> "_X
nnoremap <Del> "_x
nnoremap <leader>d "*d
nnoremap <leader>D "*D
vnoremap <leader>d "*d

" Indent and keep selection
vmap < <gv
vmap > >gv


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
let g:airline_theme             = 'nord'
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
" auto-pairs
"""""""""""""""""""""""""""""""
let g:AutoPairsMapBS=0  " do not delete in pairs


"""""""""""""""""""""""""""""""
" Fugitive
"""""""""""""""""""""""""""""""
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>


"""""""""""""""""""""""""""""""
" fzf
"""""""""""""""""""""""""""""""

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'
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

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
"imap <c-x><c-f> <plug>(fzf-complete-path)
"imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using Vim function
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')

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

" Hide statusline
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler


"""""""""""""""""""""""""""""""
" ale
"""""""""""""""""""""""""""""""

" keep gutter open
let g:ale_sign_column_always = 1

" fixers and linters
let g:ale_linters_explicit = 1
let g:ale_linters = {'html': ['htmlhint'], 'javascript': ['tsserver']}
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'javascript': ['prettier'], 'css': ['prettier'], 'html': ['html-beautify']}

nmap <Leader>p :ALEFix<CR>


"""""""""""""""""""""""""""""""
" coc
"""""""""""""""""""""""""""""""

let g:coc_global_extensions = ['coc-json','coc-tsserver','coc-html','coc-css','coc-yaml']

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Fix autofix problem of current line
"nmap <leader>qf  <Plug>(coc-fix-current)
nmap C-1  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 CocFormat :call CocAction('format')
nmap <Leader>f :CocFormat<CR>

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


"""""""""""""""""""""""""""""""
" emmet
"""""""""""""""""""""""""""""""

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key='<C-y>'


"""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""

map <F2> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Shortcut for closing text buffer and switching to next file buffer
nnoremap <leader>q :bp<cr>:bd #<cr>

let g:NERDTreeIndicatorMapCustom = {
                \ "Modified"  : "",
                \ "Staged"    : "",
                \ "Untracked" : "",
                \ "Renamed"   : "",
                \ "Unmerged"  : "",
                \ "Deleted"   : "",
                \ "Dirty"     : "",
                \ "Clean"     : "",
                \ "Unknown"   : ""
                \ }

"""""""""""""""""""""""""""""""
" Vista
"""""""""""""""""""""""""""""""

map <F3> :Vista!!<CR>

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious. e.g., more compact: ["▸ ", ""]
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'coc'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
  \ 'cpp': 'vim_lsp',
  \ 'php': 'vim_lsp',
  \ }

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
