vim.keymap.set("i", "jk", "<Esc>")
-- ~/.config/nvim/lua/keymaps.lua
local claude = require("claude-integration")

vim.keymap.set("n", "<leader>ca", claude.claude_code_current_file, { desc = "Claude analyze file" })
vim.keymap.set("v", "<leader>cr", claude.claude_review_selection, { desc = "Claude review selection" })
vim.keymap.set("n", "<leader>ct", claude.claude_generate_tests, { desc = "Claude generate tests" })
