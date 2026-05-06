-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set up jk and kj mappings early (before LazyVim loads)
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk", noremap = true, silent = true })
vim.keymap.set("i", "kj", "<Esc>", { desc = "Exit insert mode with kj", noremap = true, silent = true })
