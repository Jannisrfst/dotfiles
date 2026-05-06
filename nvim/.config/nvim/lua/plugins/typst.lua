-- Typst support for LazyVim
return {
  -- Typst syntax highlighting and basic support
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false,
  },

  -- Add Typst treesitter parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typst" })
      end
    end,
  },

  -- Configure Typst LSP (tinymist)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {
          keys = {
            { "<leader>tp", "<cmd>TypstPreview<cr>", desc = "Preview Typst document" },
            { "<leader>tc", "<cmd>TypstCompile<cr>", desc = "Compile Typst document" },
            { "<leader>tw", "<cmd>TypstWatch<cr>", desc = "Watch Typst document" },
          },
          settings = {
            exportPdf = "onType",
            outputPath = "$root/target/$dir/$name",
          },
        },
      },
    },
  },

  -- Ensure tinymist LSP is installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "tinymist" })
    end,
  },

  -- Typst preview plugin
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "0.3.*",
    build = function()
      require("typst-preview").update()
    end,
    opts = {
      -- Setting this true will enable printing debug information with print()
      debug = false,
      -- Custom format string to open the output link provided with %s
      -- Example: open_cmd = 'firefox %s'
      open_cmd = nil,
      -- Setting this to 'always' will invert black and white in the preview
      -- Setting this to 'auto' will invert depending if the browser has dark mode enabled
      invert_colors = "never",
      -- Whether the preview will follow the cursor in the source file
      follow_cursor = true,
      -- Provide the path to binaries for dependencies.
      -- Setting this will skip the download of the binary by the plugin.
      -- Warning: Be aware that your version might be older than the one
      -- required.
      dependencies_bin = {
        ["typst-preview"] = nil,
        ["websocat"] = nil,
      },
      -- A list of extra arguments (or nil) to be passed to previewer.
      -- For example, extra_args = { "--input", "foo=bar" } will result in the
      -- command `typst-preview --input foo=bar --partial-rendering ...`
      extra_args = nil,

      -- This function will be called to determine the root of the typst project
      get_root = function(path_of_main_file)
        return vim.fn.fnamemodify(path_of_main_file, ":p:h")
      end,

      -- This function will be called to determine the main file of the typst
      -- project.
      get_main_file = function(path_of_buffer)
        return path_of_buffer
      end,
    },
  },

  -- Add Typst formatting support
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        typst = { "typstyle" },
      },
    },
  },

  -- Ensure typstyle formatter is installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "typstyle" })
    end,
  },

  -- Add Typst compilation and watch commands
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Add Typst-specific keymaps and commands
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "typst",
        callback = function(event)
          local opts = { buffer = event.buf, silent = true }

          -- Compile current Typst file to PDF
          vim.keymap.set("n", "<leader>tc", function()
            local file = vim.fn.expand("%:p")
            local output = vim.fn.expand("%:r") .. ".pdf"
            local cmd = string.format("typst compile '%s' '%s'", file, output)

            require("snacks").terminal(cmd)
          end, vim.tbl_extend("force", opts, { desc = "Compile Typst to PDF" }))

          -- Watch and compile on changes
          vim.keymap.set("n", "<leader>tw", function()
            local file = vim.fn.expand("%:p")
            local output = vim.fn.expand("%:r") .. ".pdf"
            local cmd = string.format("typst watch '%s' '%s'", file, output)

            require("snacks").terminal(cmd)
          end, vim.tbl_extend("force", opts, { desc = "Watch Typst file" }))

          -- Open compiled PDF in integrated viewer (split)
          vim.keymap.set("n", "<leader>to", function()
            local pdf_file = vim.fn.expand("%:r") .. ".pdf"
            if vim.fn.filereadable(pdf_file) == 1 then
              -- Open PDF in new vertical split
              vim.cmd("vsplit")
              vim.cmd("edit " .. pdf_file)
            else
              vim.notify("PDF file not found. Compile first with <leader>tc", vim.log.levels.WARN)
            end
          end, vim.tbl_extend("force", opts, { desc = "Open compiled PDF in split" }))

          -- Open PDF in current buffer
          vim.keymap.set("n", "<leader>tO", function()
            local pdf_file = vim.fn.expand("%:r") .. ".pdf"
            if vim.fn.filereadable(pdf_file) == 1 then
              vim.cmd("edit " .. pdf_file)
            else
              vim.notify("PDF file not found. Compile first with <leader>tc", vim.log.levels.WARN)
            end
          end, vim.tbl_extend("force", opts, { desc = "Open compiled PDF in current buffer" }))

          -- Compile and open PDF in one command
          vim.keymap.set("n", "<leader>tco", function()
            local file = vim.fn.expand("%:p")
            local output = vim.fn.expand("%:r") .. ".pdf"
            local cmd = string.format("typst compile '%s' '%s'", file, output)

            vim.fn.system(cmd)
            if vim.v.shell_error == 0 then
              vim.schedule(function()
                vim.cmd("vsplit")
                vim.cmd("edit " .. output)
              end)
            else
              vim.notify("Compilation failed", vim.log.levels.ERROR)
            end
          end, vim.tbl_extend("force", opts, { desc = "Compile and open PDF" }))

          -- Open external PDF viewer (fallback)
          vim.keymap.set("n", "<leader>toe", function()
            local pdf_file = vim.fn.expand("%:r") .. ".pdf"
            if vim.fn.filereadable(pdf_file) == 1 then
              local cmd = string.format("open '%s'", pdf_file)
              vim.fn.system(cmd)
            else
              vim.notify("PDF file not found. Compile first with <leader>tc", vim.log.levels.WARN)
            end
          end, vim.tbl_extend("force", opts, { desc = "Open compiled PDF externally" }))
        end,
      })
    end,
  },
}
