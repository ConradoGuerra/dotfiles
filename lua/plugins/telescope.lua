return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",                 -- Required dependency for Telescope
      "nvim-telescope/telescope-fzf-native.nvim", -- Optional: For faster fuzzy finding
      "nvim-telescope/telescope-ui-select.nvim", -- Optional: For UI selection
    },
    keys = {
      { "<Leader>p",  "<Cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<Leader>fg", "<Cmd>Telescope live_grep<CR>",  desc = "Grep inside files" },
      { "<Leader>fb", "<Cmd>Telescope buffers<CR>",    desc = "List and search buffers" },
      {
        "<Leader>fh",
        '<Cmd>lua require("telescope.builtin").find_files({ hidden = true })<CR>',
        desc = "Find hidden files",
      },
      {
        "<Leader>fw",
        '<Cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })<CR>',
        desc = "Grep word under cursor",
      },
    },
    config = function()
      local actions = require("telescope.actions")

      -- Custom action to delete buffers
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-w>"] = actions.delete_buffer, -- Delete buffer in insert mode
            },
            n = {
              ["<C-w>"] = actions.delete_buffer, -- Delete buffer in normal mode
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
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden", -- add this
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
