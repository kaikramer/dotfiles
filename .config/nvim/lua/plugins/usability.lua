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
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
            }
        end
    },
    "junegunn/gv.vim", -- commit history
    "junegunn/vim-easy-align",
    "windwp/nvim-autopairs",
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
