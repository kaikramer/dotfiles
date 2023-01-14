-------------------------------------------------------------------------
-- misc settings
-------------------------------------------------------------------------
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
vim.o.undolevels = 1000  -- how many undos
vim.o.undoreload = 10000 -- number of lines to save for undo
vim.o.undofile = true    -- save undos after file closes

vim.o.grepprg = "rg --vimgrep"

-- auto commands
vim.api.nvim_create_augroup("mygroup", { clear = true })
vim.cmd([[autocmd mygroup BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif]])
vim.cmd([[autocmd mygroup Filetype markdown setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab]])

-------------------------------------------------------------------------
-- key mappings
-------------------------------------------------------------------------

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

-- nvim-tree
vim.api.nvim_set_keymap('n', '<leader>nt', ":NvimTreeToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nf', ":NvimTreeFindFile<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nr', ":NvimTreeRefresh<CR>", { noremap = true })

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
vim.api.nvim_set_keymap('n', '<leader>lr', ':lua vim.lsp.buf.rename()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>lf', ':lua vim.lsp.buf.format()<cr>', { noremap = true })
vim.api.nvim_set_keymap('x', '<leader>lf', '<ESC><cmd>lua vim.lsp.buf.range_formatting()<cr>', { noremap = true })

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
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'j-hui/fidget.nvim',
      'folke/neodev.nvim',
    },
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- usability
  use 'Yggdroot/indentLine'
  use 'junegunn/gv.vim' -- commit history
  use 'lewis6991/gitsigns.nvim'
  use 'junegunn/vim-easy-align'
  use 'windwp/nvim-autopairs'
  use 'svermeulen/vim-cutlass'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'
  use 'airblade/vim-rooter'
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-lualine/lualine.nvim'

  -- colors and icons
  use 'kyazdani42/nvim-web-devicons'
  use 'norcalli/nvim-colorizer.lua'
  use 'shaunsingh/nord.nvim'
end)

local custom_lualine_theme = require('lualine.themes.nord')
custom_lualine_theme.normal.a.gui = ''
custom_lualine_theme.insert.a.gui = ''
custom_lualine_theme.visual.a.gui = ''
custom_lualine_theme.replace.a.gui = ''
custom_lualine_theme.inactive.a.gui = ''

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

require'nvim-tree'.setup {
  view = {
    centralize_selection = true,
    width = 50,
  }
}

require('lualine').setup {
  options = {
    section_separators = '',
    component_separators = '|',
    theme = custom_lualine_theme,
    icons_enabled = false,
    global_status = false
  },
  extensions = { 'nvim-tree' },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { { 'filename', path = 3 } }, -- show full path
    lualine_x = { 'fileformat', 'encoding', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        mode = 2, -- show buffer name and buffer index
        show_filename_only = false,
        buffers_color = {
            active = 'lualine_y_normal',
            inactive = 'lualine_c_normal'
          }
      }
    }
  }
}

require('telescope').setup {
  pickers = {
    find_files = {
      hidden = false
    }
  }
}

require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help', 'vim' },

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('mason').setup()
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}
mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      -- on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup()

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

require("nvim-autopairs").setup { }

