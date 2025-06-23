-- ~/.config/nvim/lua/claude-integration.lua
local M = {}

-- Quick Claude Code invocation from within Neovim
function M.claude_code_current_file()
  local file = vim.fn.expand("%:p")
  vim.cmd('terminal claude-code "Analyze and improve this file: ' .. file .. '"')
end

-- Send selected code to Claude for review
function M.claude_review_selection()
  local lines = vim.fn.getline("'<", "'>")
  local code = table.concat(lines, "\n")
  vim.cmd('terminal claude-code "Review this code for Clean Code principles: ' .. code .. '"')
end

-- Generate tests for current function
function M.claude_generate_tests()
  local file = vim.fn.expand("%:p")
  vim.cmd('terminal claude-code "Generate comprehensive tests for: ' .. file .. '"')
end

return M
