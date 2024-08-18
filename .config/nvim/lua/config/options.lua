vim.o.fileencodings = 'utf-8,latin1'    -- auto detection of file encoding
vim.o.belloff = "all"                   -- don't ring bell for anything
vim.o.joinspaces = false                -- insert only one space after sentences when joining lines
vim.o.autowrite = true                  -- automatically :write before running commands
vim.o.showcmd = true                    -- display incomplete commands
vim.o.showmode = false                  -- status line plugin already does this
vim.o.startofline = false               -- don't go to start of line with some commands
vim.o.wrap = false                      -- don't wrap long lines
vim.o.textwidth = 0                     -- no max line width
vim.o.formatoptions = 'cqrt'            -- format options: c = auto-wrap comments, q = allow formatting comments with gq, r = auto-insert comment leader, t = auto-wrap text
vim.o.completeopt = "longest,menuone"   -- popup menu doesn't select the first completion item, but inserts the longest common text of all matches; menu will come up even if there's only one match
vim.o.hidden = true                     -- keep files open without showing them
vim.o.backup = false                    -- some LSP servers have issues with backup files
vim.o.writebackup = false               -- some LSP servers have issues with backup files
vim.o.cmdheight = 1                     -- better display for messages
vim.o.updatetime = 300                  -- you will have bad experience for diagnostic messages when it's default 4000
vim.o.signcolumn = 'yes'                -- always show signcolumns
vim.o.autoindent = true                 -- add indentation from current line for next line
vim.o.cindent = true                    -- indent lines after {, before } and after cinwords
vim.o.equalalways = false               -- when closing a window, do not resize other windows
vim.o.history = 100                     -- command line history keeps 100 entries
vim.o.swapfile = false                  -- disable swap files
vim.o.showtabline = 2                   -- always show tabline
vim.o.mouse = 'a'                       -- allow mouse for all modes
vim.o.conceallevel = 0                  -- disable conceal feature (enabled by plugin indentLine)
vim.o.clipboard = "unnamedplus"
vim.opt.termguicolors = true

-- enhanced command-line completion
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"    -- first tab will complete to longest string and show the the match list, second tab will complete to first full match
vim.o.wildoptions = "pum"
vim.cmd([[ " remap arrow keys in pum so I can keep my sanity
cnoremap <expr> <Up>    pumvisible() ? "\<Left>"  : "\<Up>"
cnoremap <expr> <Down>  pumvisible() ? "\<Right>" : "\<Down>"
cnoremap <expr> <Left>  pumvisible() ? "\<Up>"    : "\<Left>"
cnoremap <expr> <Right> pumvisible() ? "\<Down>"  : "\<Right>"
]])

-- make backspace behave as in most other programs
vim.o.backspace = 'indent,eol,start'
vim.o.whichwrap = 'bs<>[]'
vim.keymap.set('n', '<BS>', '"_X', { noremap = true })
vim.keymap.set('n', '<Del>', '"_x', { noremap = true })

-- line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 4
vim.cmd([[ highlight clear SignColumn ]])

-- better performance
vim.o.cursorline = false  -- scrolling is faster without cursorline
vim.o.lazyredraw = true   -- do not update screen while executing macros etc.

-- more intuitive splits
vim.o.splitright = true
vim.o.splitbelow = true

-- searching
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.hlsearch = true

-- showing white space
vim.o.list = true
vim.o.listchars = "tab:»·,trail:·,nbsp:␣"
vim.cmd([[ highlight EoLSpace ctermfg=1 guifg=#BF616A ]])
vim.cmd([[ match EoLSpace /\s\+$/ ]])

-- tabs
vim.o.expandtab = true   -- use the appropriate number of spaces to insert a tab (Ctrl-V<tab> inserts real tab)
vim.o.smarttab = true    -- smart tab and backspace
vim.o.shiftround = true  -- round indent to multiple of 'shiftwidth'
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- undo
vim.o.undolevels = 1000  -- how many undos
vim.o.undoreload = 10000 -- number of lines to save for undo
vim.o.undofile = true    -- save undos after file closes

vim.o.grepprg = "rg --vimgrep"

-- auto commands
vim.api.nvim_create_augroup("mygroup", { clear = true })
vim.cmd([[autocmd mygroup BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif]])
vim.cmd([[autocmd mygroup Filetype markdown setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab]])

-- when file is not readable or writable, automatically use suda
vim.cmd([[ let g:suda_smart_edit = 1 ]])


