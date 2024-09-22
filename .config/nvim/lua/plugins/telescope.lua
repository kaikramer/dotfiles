return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup {
                defaults = {
                    border = true
                },
                pickers = {
                    find_files = {
                        hidden = false
                    }
                }
            }

            vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "Buffers", noremap = true })
            vim.keymap.set('n', '<leader>fc', require('telescope.builtin').commands, { desc = "Commands", noremap = true })
            vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Find files", noremap = true })
            vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = "Grep", noremap = true })
            vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = "Help", noremap = true })
            vim.keymap.set('n', '<leader>fj', require('telescope.builtin').jumplist, { desc = "Jump list", noremap = true })
            vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = "Keymaps", noremap = true })
            vim.keymap.set('n', '<leader>fn', function ()
               require('telescope.builtin').find_files({ cwd = "~/.config/nvim", results_title = "Config" })
            end, { desc = "Config files", noremap = true })
            vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = "Old files", noremap = true })
            vim.keymap.set('n', '<leader>fp', require('telescope.builtin').pickers, { desc = "Pickers", noremap = true })
            vim.keymap.set('n', '<leader>fr', require('telescope.builtin').registers, { desc = "Registers", noremap = true })
            vim.keymap.set('n', '<leader>fs', require('telescope.builtin').grep_string, { desc = "Grep current string", noremap = true })
        end
    }
}
