-- lua/plugins/copilot.lua
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "BufReadPost",
  opts = {
    suggestion = {
      enabled = false, -- Enable ghost text suggestions
      auto_trigger = true, -- Suggestions appear automatically as you type
      hide_during_completion = false, -- Show ghost text even when completion menu is open
      keymap = {
        accept = "<Tab>", -- Accept suggestion with Tab (customize if needed)
        next = "<M-]>",
        prev = "<M-[>",
      },
    },
    panel = { enabled = false }, -- Disable Copilot panel (optional)
    filetypes = {
      markdown = true,
      help = true,
      -- Add or remove filetypes as needed
    },
  },
}
