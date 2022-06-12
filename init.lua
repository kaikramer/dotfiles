
-- misc settings
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
vim.o.clipboard = "unnamed"

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = true
vim.g.nord_enable_sidebar_background = true
vim.g.nord_cursorline_transparent = false
vim.g.nord_italic = false
require('nord').set()
vim.cmd([[
hi Normal guibg=#282C34
]])

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
vim.api.nvim_set_keymap('n', '<BS>', '"_X', { noremap = true })
vim.api.nvim_set_keymap('n', '<Del>', '"_x', { noremap = true })

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
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- undo
vim.o.undolevels = 1000             -- how many undos
vim.o.undoreload = 10000            -- number of lines to save for undo
vim.o.undofile = true               -- save undos after file closes

vim.o.grepprg = "rg --vimgrep"

-- key mappings

vim.g.mapleader = " "

vim.api.nvim_set_keymap('n', '<C-n>', ':bn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-p>', ':bpCR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>v', ":vsp ~/.config/nvim/init.lua<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>q', ":call QFixToggle()<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>w', [[:let _s=@/ <Bar> :%s/\s\+$//e <Bar> :%s/\r//ge <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>]], { noremap = true })

-- telescope
vim.api.nvim_set_keymap('n', '<leader>t', "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r', "<cmd>lua require('telescope.builtin').live_grep()<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>b', "<cmd>lua require('telescope.builtin').buffers()<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>k', "<cmd>lua require('telescope.builtin').keymaps()<CR>", { noremap = true })

-- lsp
vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gw', ':lua vim.lsp.buf.workspace_symbol()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gt', ':lua vim.lsp.buf.type_definition()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-1>', ':lua vim.lsp.buf.code_action()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rn', ':lua vim.lsp.buf.rename()<cr>', { noremap = true })

-- use more accessible prefixes for vim-unimpaired
vim.api.nvim_set_keymap('n', 'ö', '[', { noremap = false })
vim.api.nvim_set_keymap('n', 'ä', ']', { noremap = false })
vim.api.nvim_set_keymap('o', 'ö', '[', { noremap = false })
vim.api.nvim_set_keymap('o', 'ä', ']', { noremap = false })
vim.api.nvim_set_keymap('x', 'ö', '[', { noremap = false })
vim.api.nvim_set_keymap('x', 'ä', ']', { noremap = false })

-- together with cutlass use x for cut
vim.api.nvim_set_keymap('n', 'x', 'd', { noremap = true })
vim.api.nvim_set_keymap('x', 'x', 'd', { noremap = true })
vim.api.nvim_set_keymap('n', 'xx', 'dd', { noremap = true })
vim.api.nvim_set_keymap('n', 'X', 'D', { noremap = true })

-------------------------------------------------------------------------
-- plugins
-------------------------------------------------------------------------

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- LSP and related
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  -- usability
  use 'Yggdroot/indentLine'
  use 'junegunn/gv.vim' -- commit history
  use 'junegunn/vim-easy-align'
  use 'windwp/nvim-autopairs'
  use 'svermeulen/vim-cutlass'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'
--  use 'airblade/vim-rooter'

  -- colors and icons
  use 'norcalli/nvim-colorizer.lua'
  use { 'catppuccin/nvim', as = 'catppuccin' }
  use 'shaunsingh/nord.nvim'

  -- Treesitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'} }
  }
end)

local custom_lualine_theme = require('lualine.themes.nord')
custom_lualine_theme.normal.a.gui = ''
custom_lualine_theme.insert.a.gui = ''
custom_lualine_theme.visual.a.gui = ''
custom_lualine_theme.replace.a.gui = ''
custom_lualine_theme.inactive.a.gui = ''

require('lualine').setup {
  options = {
    section_separators = '',
    component_separators = '',
    theme = custom_lualine_theme
  }
}

require('telescope').setup{
  pickers = {
    find_files = {
      hidden = false
    }
  }
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true
  },
  indent = {
    enable = false
  }
}

vim.lsp.set_log_level("debug")
require('vim.lsp.log').set_format_func(vim.inspect)

local cmp = require "cmp"
local luasnip = require "luasnip"
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.html.setup { capabilities = capabilities }

HOME = os.getenv("HOME")
require'lspconfig'.sumneko_lua.setup {
  cmd = { HOME .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server" },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require("nvim-autopairs").setup { }

