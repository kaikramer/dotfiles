local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local ok, lazy = pcall(require, "lazy")
if ok then
    lazy.setup("plugins", {
        change_detection = {
            notify = false,
        },
    })
    vim.keymap.set('n', '<leader>L', require("lazy").show, { desc = "Lazy", noremap = true })
else
    vim.notify("Unable to load lazy.nvim")
end

require("config.options")
require("config.keymaps")
require("config.autocmds")
