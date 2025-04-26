return {
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require("symbols-outline").setup {
                autofold_depth = 0
            }
            vim.keymap.set('n', '<leader>o', ":SymbolsOutline<CR>", { noremap = true })
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup {
                -- signs = {
                --     add = { text = '+' },
                --     change = { text = '~' },
                --     delete = { text = '_' },
                --     topdelete = { text = '‾' },
                --     changedelete = { text = '~' },
                -- },
            }
        end
    },
    "junegunn/gv.vim", -- commit history
    "junegunn/vim-easy-align",
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
        opts = {
            disable_filetype = { "TelescopePrompt" },
            disable_in_macro = true, -- disable when recording or executing a macro
            disable_in_visualblock = false, -- disable when insert after visual block mode
            disable_in_replace_mode = true,
            ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
            enable_moveright = true,
            enable_afterquote = true, -- add bracket pairs after quote
            enable_check_bracket_line = true, --- check bracket in same line
            enable_bracket_in_quote = true, --
            enable_abbr = false,      -- trigger abbreviation
            break_undo = true,        -- switch for basic rule break undo sequence
            check_ts = false,
            map_cr = true,
            map_bs = true, -- map the <BS> key
            map_c_h = false, -- Map the <C-h> key to delete a pair
            map_c_w = false, -- map <c-w> to delete a pair if possibl
        }
    },
    {
        "svermeulen/vim-cutlass",
        config = function()
            -- use x for cut
            vim.keymap.set('n', 'x', 'd', { noremap = true })
            vim.keymap.set('x', 'x', 'd', { noremap = true })
            vim.keymap.set('n', 'xx', 'dd', { noremap = true })
            vim.keymap.set('n', 'X', 'D', { noremap = true })
        end
    },
    "tpope/vim-fugitive",
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "tpope/vim-commentary",
    {
        "tpope/vim-unimpaired",
        -- lazy = false,
        init = function()
            vim.keymap.set({'n', 'o', 'x'}, 'ö', '[', { remap = true })
            vim.keymap.set({'n', 'o', 'x'}, 'ä', ']', { remap = true })
        end
    },
    "tpope/vim-vinegar",
    "airblade/vim-rooter",
    "lambdalisue/suda.vim",
}
