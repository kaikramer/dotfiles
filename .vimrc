scriptencoding utf-8

call plug#begin('~/.vim/plugged')
    " syntax and language support
    Plug 'dense-analysis/ale'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'sheerun/vim-polyglot'
    Plug 'pearofducks/ansible-vim'
    Plug 'mattn/emmet-vim'

    " side bars
    Plug 'scrooloose/nerdtree', {'on': ['NERDTreeFind', 'NERDTreeClose', 'NERDTreeToggle', 'NERDTreeRefreshRoot']}
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'liuchengxu/vista.vim'
    Plug 'mbbill/undotree'

    " git
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " usability
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-commentary'
    Plug 'vim-scripts/ReplaceWithRegister'
    Plug 'junegunn/vim-peekaboo'
    Plug 'junegunn/vim-easy-align'
    Plug 'christoomey/vim-tmux-navigator'

    " searching
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'
    Plug 'dyng/ctrlsf.vim'

    " status line
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
    Plug 'maximbaz/lightline-ale'

    " colors and icons
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'arcticicestudio/nord-vim'
    Plug 'ayu-theme/ayu-vim'
    Plug 'rakr/vim-one'
    Plug 'cocopon/iceberg.vim'
    Plug 'ryanoasis/vim-devicons'
call plug#end()

" declare self-cleaning augroup and add all autocmds to that group later
augroup mygroup
    autocmd!
augroup end

" colors
syntax on
if (has('termguicolors'))
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
let ayucolor='mirage'
set background=dark
colorscheme nord

set fileencodings=utf-8,latin1  " auto detection of file encoding
set visualbell                  " flash screen, no beeping
set t_vb=                       " no flash
set noerrorbells                " don't ring bell for error messages
set nojoinspaces                " insert only one space after sentences when joining lines
set whichwrap=<,>,h,l,b         " allow specified keys that move the cursor left/right to move to the previous/next line
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
set cursorline

" more intuitive splits
set splitright
set splitbelow

" searching
set hlsearch
set incsearch
set ignorecase

" folding
set foldmethod=indent
set foldnestmax=3
set nofoldenable
set foldlevel=1

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

autocmd mygroup Filetype c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab

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

" jump to the last position when reopening a file
autocmd mygroup BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif


"""""""""""""""""""""""""""""""
" shortcuts
"""""""""""""""""""""""""""""""

let mapleader=' '

" switching between buffers
nnoremap <C-b> :bp<cr>
nnoremap <C-n> :bn<cr>

" map a few common things to do with FZF
nnoremap <silent> <leader>fa :Maps<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fc :Commits<CR>
nnoremap <silent> <leader>ff :FZF -m<CR>
nnoremap <silent> <leader>fg :GFiles<CR>
nnoremap <silent> <leader>fh :Helptags<CR>
nnoremap <silent> <leader>fl :Lines<CR>
nnoremap <silent> <leader>fm :Marks<CR>
nnoremap <silent> <leader>fo :Colors<CR>
nnoremap <silent> <leader>fr :Rg<CR>

" CtrlSF
nnoremap <leader>r :CtrlSF --hidden<Space>
vmap <silent> <leader>r <Plug>CtrlSFVwordExec

" miscellaneous mappings
nnoremap <silent> <leader>qf :call QFixToggle()<CR>
nnoremap <silent> <leader>qn :cnext<CR>
nnoremap <silent> <leader>qp :cprevious<CR>
nnoremap <silent> <leader>af :ALEFix<CR>
nnoremap <silent> <leader>ut :UndotreeShow<CR>
nnoremap <silent> <leader>st :Vista!!<CR>

" NERDTree
nnoremap <silent> <leader>nt :NERDTreeToggle<CR>
nnoremap <silent> <leader>nf :NERDTreeFind<CR>
nnoremap <silent> <leader>nc :bp<cr>:bd #<cr>

" CoC
nnoremap <silent> gd <Plug>(coc-definition)  " use standard mapping for 'goto definition'
nnoremap <silent> <leader>cf :CocFormat<CR>
nnoremap <silent> <leader>cd :call <SID>show_documentation()<CR>
nnoremap <silent> <leader>co :call CocAction('runCommand', 'editor.action.organizeImport')
nmap <silent> <leader>cr <Plug>(coc-references)
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" EasyAlign (e.g. vipga=, gaip*= or )
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nnoremap <silent> <leader>v :edit ~/.vimrc<CR>

" Indent and keep selection
vmap < <gv
vmap > >gv

" w!! let's you sudo after file was opened!
cmap w!! w !sudo tee % >/dev/null


"""""""""""""""""""""""""""""""
" lightline
"""""""""""""""""""""""""""""""

let g:lightline = {}
let g:lightline.colorscheme = 'nord'
let g:lightline.enable = { 'statusline': 1, 'tabline': 1 }

set showtabline=2
let g:lightline.tabline = {'left': [['buffers']], 'right': [[ 'buffers_text' ]]}
let g:lightline#bufferline#show_number = 0
let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#enable_devicons = 1

let g:lightline.component = {
     \ 'lineinfo': '%3l/%L : %-2v',
     \ 'buffers_text': 'buffers',
     \}
let g:lightline.component_expand = {
    \ 'buffers': 'lightline#bufferline#buffers',
    \ 'linter_checking': 'lightline#ale#checking',
    \ 'linter_infos': 'lightline#ale#infos',
    \ 'linter_warnings': 'lightline#ale#warnings',
    \ 'linter_errors': 'lightline#ale#errors',
    \ 'linter_ok': 'lightline#ale#ok',
    \}
let g:lightline.component_function = {
    \ 'readonly': 'LightlineReadonly',
    \ 'fugitive': 'LightlineFugitive',
	\ 'cocstatus': 'coc#status',
    \}
let g:lightline.component_type = {
    \ 'buffers': 'tabsel',
    \ 'linter_checking': 'right',
    \ 'linter_infos': 'right',
    \ 'linter_warnings': 'warning',
    \ 'linter_errors': 'error',
    \ 'linter_ok': 'right',
    \}

let g:lightline.active = {
    \ 'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'absolutepath', 'modified' ] ],
    \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'cocstatus' ], [ 'lineinfo' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \}

" use powerline/nerdfont symbols
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
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

let g:lightline#ale#indicator_checking = ''
let g:lightline#ale#indicator_warnings = '🔔'
let g:lightline#ale#indicator_errors = '⛔'
let g:lightline#ale#indicator_ok = ''

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" Use autocmd to force lightline update.
autocmd mygroup User CocStatusChange,CocDiagnosticChange call lightline#update()


"""""""""""""""""""""""""""""""
" fzf
"""""""""""""""""""""""""""""""

let $FZF_DEFAULT_COMMAND = 'fd --type file --hidden --no-ignore --exclude .git'

" Ignore filename for ripgrep
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
let g:fzf_layout = { 'window': 'enew' }

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


"""""""""""""""""""""""""""""""
" ale
"""""""""""""""""""""""""""""""

" Keep gutter open
let g:ale_sign_column_always = 1

" Use quickfix list instead of loclist
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
function! QFixToggle()
  if exists('g:qfix_win')
    cclose
    unlet g:qfix_win
  else
    copen 15
    let g:qfix_win = bufnr('$')
  endif
endfunction

" Fixers
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'javascript': ['prettier'], 'css': ['prettier'], 'html': ['html-beautify']}

" Symbols and colors
highlight ALEErrorSign guifg=red
highlight ALEWarningSign guifg=yellow
let g:ale_sign_error = '⛔'
let g:ale_sign_warning = '🔔'


"""""""""""""""""""""""""""""""
" coc
"""""""""""""""""""""""""""""""

let g:coc_global_extensions = ['coc-json','coc-html','coc-css','coc-yaml','coc-vimlsp','coc-python']

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


"""""""""""""""""""""""""""""""
" emmet
"""""""""""""""""""""""""""""""

let g:user_emmet_install_global = 0
autocmd mygroup FileType html,css EmmetInstall


"""""""""""""""""""""""""""""""
" NERDTree
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


"""""""""""""""""""""""""""""""
" Vista
"""""""""""""""""""""""""""""""

let g:vista_sidebar_width = 50

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious. e.g., more compact: ["▸ ", ""]
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
let g:vista_icon_indent = ['╰─▸ ', '├─▸ ']

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
\   'function': '\uf794',
\   'variable': '\uf71b',
\  }


"""""""""""""""""""""""""""""""
" tmux navigator
"""""""""""""""""""""""""""""""

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <M-Left>  :TmuxNavigateLeft<cr>
nnoremap <silent> <M-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <M-Down>  :TmuxNavigateDown<cr>
nnoremap <silent> <M-Up>    :TmuxNavigateUp<cr>


"""""""""""""""""""""""""""""""
" CtrlSF
"""""""""""""""""""""""""""""""

let g:ctrlsf_confirm_save = 0

" search for .git instead of using current working directory
let g:ctrlsf_default_root = 'project'

" focus result pane right at the start
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }


"""""""""""""""""""""""""""""""
" Misc plugins
"""""""""""""""""""""""""""""""

" ansible-vim
autocmd mygroup BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible

" peekaboo
let g:peekaboo_window = 'vert bo 50new'

" nvim-colorizer.lua
if has('nvim')
    lua require'colorizer'.setup()
end

