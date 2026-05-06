-- Exercism.nvim plugin configuration
-- This plugin provides integration with Exercism coding exercises

return {
  -- Required dependencies
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
  },
  
  -- Utils.nvim dependency for utility functions
  {
    "2KAbhishek/utils.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("utils").setup()
    end,
    lazy = true,
  },
  
  -- Termim.nvim dependency for terminal support (provides :STerm command)
  {
    "2KAbhishek/termim.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("termim").setup({
        -- Terminal configuration
        shell = vim.o.shell,
        size = 15,
        direction = "horizontal",
        close_on_exit = false,
        auto_scroll = true,
      })
    end,
    lazy = true,
  },
  
  -- Main exercism.nvim plugin
  {
    "2KAbhishek/exercism.nvim",
    dependencies = {
      "2KAbhishek/utils.nvim",
      "2KAbhishek/termim.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("exercism").setup({
        -- Enable default key bindings
        add_default_keybindings = true,
        
        -- Default language for new exercises (you can change this to your preferred language)
        default_language = "c",
        
        -- Exercism workspace directory (will use exercism CLI default if not specified)
        exercism_workspace = "~/exercism",
        
        -- Maximum number of recent exercises to keep
        max_recents = 30,
        
        -- Icons for different exercise types
        icons = {
          concept = "󰋘", -- Icon for concept exercises
          practice = "󰠖", -- Icon for practice exercises
        },
      })
    end,
    cmd = {
      "Exercism",
    },
    keys = {
      -- Default keybindings (these will be set automatically if add_default_keybindings = true)
      { "<leader>exa", "<cmd>Exercism languages<cr>", desc = "List Exercism languages" },
      { "<leader>exl", "<cmd>Exercism list<cr>", desc = "List Exercism exercises" },
      { "<leader>ext", "<cmd>Exercism test<cr>", desc = "Test Exercism exercise" },
      { "<leader>exs", "<cmd>Exercism submit<cr>", desc = "Submit Exercism exercise" },
      { "<leader>exr", "<cmd>Exercism recents<cr>", desc = "Show recent Exercism exercises" },
    },
  },
}
