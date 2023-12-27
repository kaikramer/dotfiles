
-- switch buffers
vim.keymap.set('n', '<C-n>', ':bn<CR>', { noremap = true })
vim.keymap.set('n', '<C-p>', ':bp<CR>', { noremap = true })

-- some easy access keymaps
vim.keymap.set('n', '<leader>v', ":vsp ~/.config/nvim/init.lua<CR>", { desc = "Vim config", noremap = true })
vim.keymap.set('n', '<leader>q', ":call QFixToggle()<CR>", { desc = "Quickfix toggle", noremap = true })
vim.keymap.set('n', '<leader>w', [[:let _s=@/ <Bar> :%s/\s\+$//e <Bar> :%s/\r//ge <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>]], { desc = "Remove trailing white space", noremap = true })
