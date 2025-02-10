return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>b", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
    { "<leader>e", "<cmd>Neotree reveal<cr>", desc = "Reveal Explorer" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true, -- Close NeoTree if it's the last open window
      popup_border_style = "rounded",
      enable_git_status = true, -- Show Git status indicators
      enable_diagnostics = true, -- Show diagnostic indicators (e.g., LSP errors)
      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          context_marker = "",
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,                    -- Hide hidden files by default
        },
        follow_current_file = { enable = true }, -- Keep the current file centered in the tree
        use_libuv_file_watcher = true,
      },
      window = {
        position = "left", -- Position of the NeoTree window
        width = 30,    -- Width of the NeoTree window
      },
    })
  end,
}
