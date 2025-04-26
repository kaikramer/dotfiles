local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.opt.termguicolors = true
vim.g.mapleader = " "

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  checker = { enabled = false }, -- don't check for plugin updates periodically
  change_detection = { notify = false }, -- don't notify about config changes
})
vim.keymap.set("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Lazy" })

require("config.options")
require("config.keymaps")
require("config.autocmds")

