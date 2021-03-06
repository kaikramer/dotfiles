scriptencoding utf-8

"{{{ plugins
call plug#begin('~/.vim/plugged')
    " syntax and language support
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'sheerun/vim-polyglot'
    Plug 'pearofducks/ansible-vim'

    " side bars
    Plug 'scrooloose/nerdtree', {'on': ['NERDTreeFind', 'NERDTreeClose', 'NERDTreeToggle', 'NERDTreeRefreshRoot']}
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'liuchengxu/vista.vim'
    Plug 'mbbill/undotree'
    Plug 'mcchrish/nnn.vim'
    Plug 'dyng/ctrlsf.vim'

    " git
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " usability
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-vinegar'
    Plug 'junegunn/vim-easy-align'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'liuchengxu/vim-which-key'
    Plug 'svermeulen/vim-cutlass'

    " searching
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'

    " status line
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'

    " colors and icons
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'gruvbox-community/gruvbox'
    Plug 'ryanoasis/vim-devicons'
call plug#end()
"}}}

" {{{ self-cleaning augroup
augroup mygroup
    autocmd!
augroup end
"}}}

" {{{ colors
syntax on
if (has('termguicolors'))
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
let ayucolor='mirage'
set t_md=
let g:gruvbox_italic = 0
let g:gruvbox_bold = 0
let g:gruvbox_contrast_dark = 'hard' " soft/medium/hard
set background=dark
colorscheme gruvbox
" }}}

" misc settings {{{
set fileencodings=utf-8,latin1  " auto detection of file encoding
set visualbell                  " flash screen, no beeping
set t_vb=                       " no flash
set noerrorbells                " don't ring bell for error messages
set nojoinspaces                " insert only one space after sentences when joining lines
set whichwrap+=<,>,h,l,[,]      " allow left/right arrow keys and h/l to move the cursor to the previous/next line
set ruler                       " show the cursor position all the time
set autowrite                   " automatically :write before running commands
set showcmd                     " display incomplete commands
set noshowmode                  " plugin lightline already does this
set nostartofline               " don't goto start of line with some commands
set nowrap                      " don't wrap long lines
set textwidth=0                 " no max line width
set wildmenu                    " enhanced command-line completion
set formatoptions=cqrt          " format options: c = auto-wrap comments, q = allow formatting comments with gq, r = auto-insert comment leader, t = auto-wrap text
set shortmess=atToO             " no shortening of messages
set shortmess+=c                " don't give ins-completion-menu messages.
set comments=b:#,:%,fb:-,n:>,n:),sl:/**,mb:\ *,elx:\ */
set completeopt=longest,menuone " popup menu doesn't select the first completion item, but inserts the longest common text of all matches; menu will come up even if there's only one match
set hidden                      " if hidden is not set, TextEdit might fail.
set nobackup                    " some LSP servers have issues with backup files, see #649
set nowritebackup               " some LSP servers have issues with backup files, see #649
set cmdheight=2                 " better display for messages
set updatetime=300              " you will have bad experience for diagnostic messages when it's default 4000.
set signcolumn=yes              " always show signcolumns
set autoindent                  " add indentation from current line for next line
set cindent                     " indent lines after {, before } and after cinwords
set scrolloff=5                 " scroll offset in lines
set clipboard=unnamed

if !has('nvim')
    set viminfo=%,'50,\"100,:100,n~/.viminfo
endif

" make backspace behave as in most other programs
set backspace=indent,eol,start
nnoremap <BS> "_X
nnoremap <Del> "_x

" line numbers
set relativenumber
set number
set numberwidth=4

" better performance
set nocursorline                " scrolling is faster without cursorline
set lazyredraw                  " do not update screen while executing macros etc.
set ttyfast                     " only for vim (removed in neovim)

" more intuitive splits
set splitright
set splitbelow

" searching
set hlsearch
set incsearch
set ignorecase

" folding
set foldmethod=marker
set foldenable
set foldlevel=0

" show white space?
set list
set listchars=tab:»·,trail:·,nbsp:␣
highlight EoLSpace ctermfg=1 guifg=#BF616A
match EoLSpace /\s\+$/

" tabs
set expandtab                   " use the appropriate number of spaces to insert a tab (Ctrl-V<tab> inserts real tab)
set smarttab                    " smart tab and backspace
set shiftround                  " round indent to multiple of 'shiftwidth'
set tabstop=4
set shiftwidth=4

" filetype specific settings
autocmd mygroup Filetype c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd mygroup Filetype markdown setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd mygroup Filetype java setlocal nolist noexpandtab

set history=100

" mouse support
set mouse=a
if !has('nvim')
    if has('mouse_sgr')
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
"if has('persistent_undo')       " create undo dir if it does not exist
"    let myUndoDir = expand(vimDir . '/undo')
"    call system('mkdir ' . vimDir)
"    call system('mkdir ' . myUndoDir)
"    let &undodir = myUndoDir
"endif
set undofile                    " Save undos after file closes
set undodir=$HOME/.vim/undo     " where to save undo histories

" netrw
let g:netrw_banner = 1
let g:netrw_winsize = 25
let g:netrw_browse_split = 4    " open file in previous window
let g:netrw_liststyle = 1       " wide list view
let g:netrw_altv = 1            " change from left splitting to right splitting

" jump to the last position when reopening a file
autocmd mygroup BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

set grepprg=rg\ --vimgrep

" automatically open quickfix/location window after grep/make/lvimgrep etc.
"autocmd mygroup QuickFixCmdPost [^l]* cwindow
"autocmd mygroup QuickFixCmdPost l*    lwindow

function! QFixToggle()
  if exists('g:qfix_win')
    cclose
    unlet g:qfix_win
  else
    copen 15
    let g:qfix_win = bufnr('$')
  endif
endfunction

"}}}

"{{{ shortcuts
"""""""""""""""""""""""""""""""
let mapleader=' '

" switching between buffers
nnoremap <C-p> :bp<cr>
nnoremap <C-n> :bn<cr>

" map a few common things to do with FZF
nnoremap <silent> <leader>fa :Maps<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fc :Commits<CR>
nnoremap <silent> <leader>g  :Files<CR>
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fg :GFiles<CR>
nnoremap <silent> <leader>fh :Helptags<CR>
nnoremap <silent> <leader>fl :Lines<CR>
nnoremap <silent> <leader>fm :Marks<CR>
nnoremap <silent> <leader>r  :Rg<CR>

" miscellaneous mappings
nnoremap <silent> <leader>m :w <Bar> :make<CR>
nnoremap <silent> <leader>q :call QFixToggle()<CR>
" nnoremap <silent> <leader>s :Vista!!<CR>
nnoremap <silent> <leader>u :UndotreeShow<CR>
xnoremap <leader>b :!boxes -d shell -s 50 -pa1<CR>

" CtrlSF
nmap     <leader>s :CtrlSF <C-R><C-W><CR>
vmap     <leader>s <Plug>CtrlSFVwordExec

" NERDTree and nnn
nnoremap <silent> <leader>nt :NERDTreeToggle<CR>
nnoremap <silent> <leader>nf :NERDTreeFind <Bar> :wincmd p<CR>
nnoremap <silent> <leader>np :Np<CR>

" note taking
nnoremap <silent> <leader>nn :call OpenNotes()<CR>
nnoremap <silent> <leader>nu :call CreateNewUnnamedNote()<CR>

" CoC
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> <leader>ca <Plug>(coc-codeaction)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cq <Plug>(coc-fix-current)
nmap <silent> <leader>cr <Plug>(coc-references)
xmap <silent> <leader>cf <Plug>(coc-format-selected)
nnoremap <silent> <leader>cf :CocFormat<CR>
nnoremap <silent> <leader>co :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
nnoremap <silent> <leader>cn :call CocAction('diagnosticNext')<CR>
nnoremap <silent> <leader>cp :call CocAction('diagnosticPrevious')<CR>
"nnoremap <silent> <leader>co :CocList outline<CR>
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" EasyAlign (e.g. vipga=, gaip*= or )
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" open vimrc
nnoremap <silent> <leader>v :vsp ~/.vimrc<CR>

" Indent and keep selection
vmap < <gv
vmap > >gv

" w!! let's you sudo after file was opened!
cmap w!! w !sudo tee % >/dev/null

" remove trailing whitespace (from https://vim.fandom.com/wiki/Remove_unwanted_spaces)
nnoremap <leader>w :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :%s/\r//ge <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Fix spacing of ansible variables
nnoremap <leader>a :%s/\M{{/{{ /g <Bar> :%s/\M}}/ }}/g <Bar> :nohl <CR>

" terminal
if has('nvim')
    autocmd mygroup TermOpen * startinsert

    " avoid interference of mapping esc for terminal with fzf
    autocmd mygroup TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
    autocmd mygroup FileType fzf tunmap <buffer> <Esc>

    nnoremap <silent> <leader>t :split<CR>:resize 10<CR>:terminal<CR>
    tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
    tnoremap <A-h> <C-\><C-N><C-w>h
    tnoremap <A-j> <C-\><C-N><C-w>j
    tnoremap <A-k> <C-\><C-N><C-w>k
    tnoremap <A-l> <C-\><C-N><C-w>l
endif

" center line when searching
nnoremap n nzzzv
nnoremap N Nzzzv

" use more accessible prefixes for vim-unimpaired
nmap ö [
nmap ä ]
omap ö [
omap ä ]
xmap ö [
xmap ä ]

" together with cutlass use x for cut
nnoremap x d
xnoremap x d
nnoremap xx dd
nnoremap X D

"}}}

"{{{ lightline
"""""""""""""""""""""""""""""""
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
let g:lightline.enable = { 'statusline': 1, 'tabline': 1 }

set showtabline=2
let g:lightline.tabline = {'left': [['buffers']], 'right': [[ 'buffers_text' ]]}
let g:lightline#bufferline#show_number = 0
let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline#bufferline#filename_modifier = ':.'
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#clickable = 1
let g:lightline.component_raw = {'buffers': 1}

let g:lightline.component = {
     \ 'lineinfo': '%3l/%L : %-2v',
     \ 'buffers_text': 'buffers',
     \}
let g:lightline.component_expand = {
    \ 'buffers': 'lightline#bufferline#buffers',
    \ 'coc_hint': 'LightlineCocHints',
    \ 'coc_info': 'LightlineCocInfos',
    \ 'coc_warning': 'LightlineCocWarnings',
    \ 'coc_error': 'LightlineCocErrors',
    \}
let g:lightline.component_function = {
    \ 'readonly': 'LightlineReadonly',
    \ 'fugitive': 'LightlineFugitive',
    \ 'cocstatus': 'coc#status',
    \}
let g:lightline.component_type = {
    \ 'buffers': 'tabsel',
    \ 'coc_warning': 'warning',
    \ 'coc_error': 'error',
    \ 'coc_hint': 'middle',
    \ 'coc_info': 'tabsel',
    \}

let g:lightline.active = {
    \ 'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'absolutepath', 'modified' ] ],
    \ 'right': [ [ 'coc_status', 'coc_error', 'coc_warning', 'coc_hint', 'coc_info' ],
    \            [ 'lineinfo' ],
    \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \}

" use powerline/nerdfont symbols
let g:lightline.separator = { 'left': ' ', 'right': ' ' }
function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
    if exists('*FugitiveHead')
        let branch = FugitiveHead()
        return branch !=# '' ? ' '.branch : ''
    endif
    return ''
endfunction

function! s:lightline_coc_diagnostic(kind, sign) abort
  let info = get(b:, 'coc_diagnostic_info', 0)
  if empty(info) || get(info, a:kind, 0) == 0
    return ''
  endif
  try
    let s = g:coc_user_config['diagnostic'][a:sign . 'Sign']
  catch
    let s = ''
  endtry
  return printf('%s %d', s, info[a:kind])
endfunction
function! LightlineCocErrors() abort
    return s:lightline_coc_diagnostic('error', 'E')
endfunction
function! LightlineCocWarnings() abort
    return s:lightline_coc_diagnostic('warning', 'W')
endfunction
function! LightlineCocInfos() abort
    return s:lightline_coc_diagnostic('information', 'I')
endfunction
function! LightlineCocHints() abort
    return s:lightline_coc_diagnostic('hints', 'H')
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" Use autocmd to force lightline update.
autocmd mygroup User CocStatusChange,CocDiagnosticChange call lightline#update()

"}}}

"{{{ fzf
"""""""""""""""""""""""""""""""
let $FZF_DEFAULT_COMMAND = 'fd --type file --hidden --no-ignore --exclude .git'

" Ignore filename for ripgrep
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6 } }

let g:fzf_preview_window = 'right:60%'

" Customize fzf colors to match your color scheme
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

" Hide statusline
autocmd mygroup FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd mygroup BufLeave <buffer> set laststatus=2 showmode ruler

"}}}

"{{{ coc
"""""""""""""""""""""""""""""""
let g:coc_global_extensions = ['coc-marketplace','coc-json','coc-xml','coc-html','coc-css','coc-yaml','coc-vimlsp','coc-python']

let g:coc_filetype_map = {
    \ 'yaml.ansible': 'yaml',
    \ }

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use `:Format` to format current buffer
command! -nargs=0 CocFormat :call CocAction('format')

"}}}

"{{{ NERDTree
"""""""""""""""""""""""""""""""
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 50
let g:NERDTreeAutoDeleteBuffer = 1

" Make sure no files or other buffers are opened in NT buffer
autocmd mygroup BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

" Close vim if only NT window left
autocmd mygroup BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeIndicatorMapCustom = {
                \ 'Modified'  : '',
                \ 'Staged'    : '',
                \ 'Untracked' : '',
                \ 'Renamed'   : '',
                \ 'Unmerged'  : '',
                \ 'Deleted'   : '',
                \ 'Dirty'     : '',
                \ 'Clean'     : '',
                \ 'Unknown'   : ''
                \ }

"}}}

"{{{ vista
"""""""""""""""""""""""""""""""
let g:vista_sidebar_width = 50

" Executive used when opening vista sidebar without specifying it.
let g:vista_default_executive = 'coc'

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
let g:vista_fzf_preview = ['right:50%']

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   'function': '',
\   'variable': 'x',
\  }

"}}}

" {{{ tmux navigator
"""""""""""""""""""""""""""""""

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <M-Left>  :TmuxNavigateLeft<cr>
nnoremap <silent> <M-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <M-Down>  :TmuxNavigateDown<cr>
nnoremap <silent> <M-Up>    :TmuxNavigateUp<cr>
" }}}

"{{{ CtrlSF
"""""""""""""""""""""""""""""""

let g:ctrlsf_confirm_save = 0

" search for .git instead of using current working directory
let g:ctrlsf_default_root = 'project'

" focus result pane right at the start
let g:ctrlsf_auto_focus = {
    \ 'at': 'start'
    \ }

" also feed quickfix and location list with search result
let g:ctrlsf_populate_qflist = 1

"}}}

" {{{ which-key
"""""""""""""""""""""""""""""""
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>

" By default timeoutlen is 1000 ms
set timeoutlen=500
"}}}

" {{{ notes
"""""""""""""""""""""""""""""""

function! CreateNewUnnamedNote()
    exec 'edit '.strftime("~/Notes/%Y-%m-%d_%H-%M-%S.md")
endfunction

function! OpenNotes()
    cd ~/Notes
    let g:netrw_banner = 1
    let g:netrw_sort_by = "time"
    let g:netrw_sort_direction = "reverse"
    leftabove vsplit
    vertical resize 50
    e.
    "call nnn#pick()
    " sort by time
    "call feedkeys("tt")
endfunction

" }}}

"{{{ nnn
"""""""""""""""""""""""""""""""

let g:nnn#set_default_mappings = 0
"let g:nnn#command = 'nnn -d'
let g:nnn#layout = { 'left': '40' } " or right, up, down

"}}}

"{{{ misc plugins
"""""""""""""""""""""""""""""""

" ansible-vim
autocmd mygroup BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
autocmd mygroup FileType yaml.ansible setlocal makeprg=ansible-lint\ -p\ %
                                   \| setlocal errorformat="%f:%l: [%t%n] %m,%f:%l: [EANSIBLE%n] %m,%f:%l: [ANSIBLE%n] %m"

" peekaboo
let g:peekaboo_window = 'vert bo 50new'

" nvim-colorizer.lua
if has('nvim')
    lua require'colorizer'.setup()
endif

" }}}
