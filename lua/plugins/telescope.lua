return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",                 -- Required dependency for Telescope
      "nvim-telescope/telescope-fzf-native.nvim", -- Optional: For faster fuzzy finding
      "nvim-telescope/telescope-ui-select.nvim", -- Optional: For UI selection
    },
    config = function()
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")

      -- Set up keymaps with descriptions
      vim.keymap.set("n", "<C-S-f>", function()
        builtin.live_grep({ hidden = true })
      end, { desc = "Search text in files (live grep)" })
      vim.keymap.set("n", "<C-p>", function()
        builtin.find_files({ hidden = true })
      end, { desc = "Find files" })
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, { desc = "Find recent files" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "List open buffers" })

      -- Custom action to delete buffers
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-S-D>"] = actions.delete_buffer, -- Delete buffer in insert mode
            },
            n = {
              ["<C-S-D>"] = actions.delete_buffer, -- Delete buffer in normal mode
            },
          },
          path_display = function(_, path)
            local filename = vim.fn.fnamemodify(path, ":t")
            local filepath = vim.fn.fnamemodify(path, ":h")
            return string.format("%s\t-\t%s", filename, filepath)
          end,
          layout_strategy = "vertical",
          width = 0.9,
          preview_height = 0.3, -- 30% of the height for the preview (bottom)
          height = 0.8,    -- Total height of the Telescope window
        },
        extensions = {
          fzf = {
            fuzzy = true,             -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      -- Load extensions
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")
    end,
  },
}
