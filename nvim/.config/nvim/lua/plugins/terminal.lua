-- Terminal configuration for LazyVim
-- Configure Snacks terminal to open as floating window
return {
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = {
          position = "float",
          border = "rounded",
          width = 0.8,
          height = 0.8,
          wo = {
            winblend = 10, -- Add some transparency
          },
        },
      },
    },
  },
}
