-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Note: jk and kj mappings are set in options.lua for early loading

-- Additional useful keymaps
local map = vim.keymap.set

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows with arrows
map("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move text up and down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Arduino/PlatformIO keymaps
map("n", "<leader>ai", ":Pioinit<CR>", { desc = "Initialize PlatformIO project" })
map("n", "<leader>ab", ":Piorun build<CR>", { desc = "Build Arduino project" })
map("n", "<leader>au", ":Piorun upload<CR>", { desc = "Upload to Arduino board" })
map("n", "<leader>am", ":Piomon<CR>", { desc = "Open serial monitor" })
map("n", "<leader>ac", ":Piocmd<CR>", { desc = "Run PlatformIO command" })
map("n", "<leader>al", ":Piolib<CR>", { desc = "Manage libraries" })

-- LSP Hover fix - ensure K uses LSP hover instead of man pages
map("n", "K", function()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #clients > 0 then
    vim.lsp.buf.hover()
  else
    -- Fall back to man pages only if no LSP
    vim.cmd("normal\! K")
  end
end, { desc = "LSP Hover Documentation", silent = true })
