return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup {
                pickers = {
                    find_files = {
                        hidden = false
                    }
                }
            }
            vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = "Find files", noremap = true })
            vim.keymap.set('n', '<leader>g', require('telescope.builtin').live_grep, { desc = "Grep", noremap = true })
            vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = "Buffers", noremap = true })
            vim.keymap.set('n', '<leader>r', require('telescope.builtin').oldfiles, { desc = "Recent files", noremap = true })
            vim.keymap.set('n', '<leader>k', require('telescope.builtin').keymaps, { desc = "Find keymaps", noremap = true })
            vim.keymap.set('n', '<leader>s', require('telescope.builtin').grep_string, { desc = "Grep current string", noremap = true })
        end
    }
}
