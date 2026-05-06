-- claudecode.nvim - Claude Code integration for Neovim
return {
  "coder/claudecode.nvim",
  lazy = true,
  cmd = { "ClaudeCode" },
  keys = {
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add buffer to context" },
    { "<leader>aB", "<cmd>ClaudeCodeAdd --below<cr>", desc = "Add below to context" },
    { "<leader>ax", "<cmd>ClaudeCodeAdd<cr>", desc = "Add selection to context", mode = "v" },
  },
  opts = {},
}
