-- Enhanced C compilation shortcuts with SDL support
return {
  -- Add compilation keymaps for C files
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Add C-specific keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp" },
        callback = function(event)
          local opts = { buffer = event.buf, silent = true }
          
          -- Compile current file
          vim.keymap.set("n", "<leader>cc", function()
            local file = vim.fn.expand("%:p")
            local file_no_ext = vim.fn.expand("%:r")
            local filename = vim.fn.expand("%:t")
            
            -- Check if file needs SDL
            local cmd
            if filename:match("SDL") or filename:match("sdl") then
              cmd = string.format("gcc -Wall -Wextra -g $(pkg-config --cflags sdl2) '%s' -o '%s' $(pkg-config --libs sdl2)", file, file_no_ext)
            else
              cmd = string.format("gcc -Wall -Wextra -g '%s' -o '%s'", file, file_no_ext)
            end

            require("snacks").terminal(cmd)
          end, vim.tbl_extend("force", opts, { desc = "Compile C file" }))
          
          -- Compile and run
          vim.keymap.set("n", "<leader>cr", function()
            local file = vim.fn.expand("%:p")
            local file_no_ext = vim.fn.expand("%:r")
            local filename = vim.fn.expand("%:t")
            
            -- Check if file needs SDL
            local compile_cmd
            if filename:match("SDL") or filename:match("sdl") then
              compile_cmd = string.format("gcc -Wall -Wextra -g $(pkg-config --cflags sdl2) '%s' -o '%s' $(pkg-config --libs sdl2)", file, file_no_ext)
            else
              compile_cmd = string.format("gcc -Wall -Wextra -g '%s' -o '%s'", file, file_no_ext)
            end
            
            local run_cmd = string.format("'%s'", file_no_ext)
            local full_cmd = compile_cmd .. " && " .. run_cmd

            require("snacks").terminal(full_cmd)
          end, vim.tbl_extend("force", opts, { desc = "Compile and run C file" }))
          
          -- Run make if Makefile exists
          vim.keymap.set("n", "<leader>cm", function()
            if vim.fn.filereadable("Makefile") == 1 or vim.fn.filereadable("makefile") == 1 then
              require("snacks").terminal("make")
            else
              vim.notify("No Makefile found", vim.log.levels.WARN)
            end
          end, vim.tbl_extend("force", opts, { desc = "Run make" }))
          
          -- Generate compile_commands.json
          vim.keymap.set("n", "<leader>cg", function()
            if vim.fn.filereadable("Makefile") == 1 or vim.fn.filereadable("makefile") == 1 then
              require("snacks").terminal("bear -- make clean all")
            else
              vim.notify("No Makefile found for generating compile_commands.json", vim.log.levels.WARN)
            end
          end, vim.tbl_extend("force", opts, { desc = "Generate compile_commands.json" }))
        end,
      })
    end,
  },
}
