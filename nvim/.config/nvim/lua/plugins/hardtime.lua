-- hardtime.nvim - Break bad habits, master Vim motions
return {
  {
    "m4xshen/hardtime.nvim",
    lazy = false, -- Load immediately to start coaching
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      max_time = 1000,        -- Time window for detecting repeated keys (ms)
      max_count = 3,          -- Max repeated keys allowed
      disable_mouse = true,   -- Encourage keyboard usage
      hint = true,           -- Show educational hints
      notification = true,   -- Show notifications
      restriction_mode = "hint", -- Use hint mode (shows suggestions but allows actions)
      allow_different_key = true, -- Allow different keys to reset count
      enabled = true,        -- Enable by default
      
      -- Custom hints for better coaching
      hints = {
        ["k%^"] = {
          message = function()
            return "Use - instead of k^"
          end,
          length = 2,
        },
        ["d[tTfF].i"] = {
          message = function(keys)
            return "Use c" .. keys:sub(2, 3) .. " instead of " .. keys
          end,
          length = 4,
        },
        ["j+"] = {
          message = function()
            return "Use relative jumps like 5j instead of repeated j"
          end,
          length = 1,
        },
        ["k+"] = {
          message = function()
            return "Use relative jumps like 5k instead of repeated k"
          end,
          length = 1,
        },
      },
      
      -- Customize which keys trigger the coaching
      restricted_keys = {
        ["h"] = { "n", "x" },
        ["j"] = { "n", "x" },
        ["k"] = { "n", "x" },
        ["l"] = { "n", "x" },
        ["-"] = { "n", "x" },
        ["+"] = { "n", "x" },
        ["gj"] = { "n", "x" },
        ["gk"] = { "n", "x" },
        ["<CR>"] = { "n", "x" },
        ["<C-M>"] = { "n", "x" },
        ["<C-N>"] = { "n", "x" },
        ["<C-P>"] = { "n", "x" },
      },
    },
  },
}
