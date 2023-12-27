return {
    {
        "kyazdani42/nvim-tree.lua",
        config = function()
            require 'nvim-tree'.setup {
                view = {
                    centralize_selection = true,
                    width = 50,
                }
            }
            vim.keymap.set('n', '<leader>nt', ":NvimTreeToggle<CR>", { noremap = true })
            vim.keymap.set('n', '<leader>nf', ":NvimTreeFindFile<CR>", { noremap = true })
            vim.keymap.set('n', '<leader>nr', ":NvimTreeRefresh<CR>", { noremap = true })
        end
    }
}
