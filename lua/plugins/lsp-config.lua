return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "gopls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true, -- Highlight unused params
            },
            staticcheck = true,    -- Enable static analysis
          },
        },
      })

      -- LSP Keymaps with Descriptions
      vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "Hover (LSP)" })
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition (LSP)" })
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Show references (LSP)" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions (LSP)" })

      -- Diagnostic Keymaps with Descriptions
      vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP completion source
      "hrsh7th/cmp-buffer",       -- Buffer completion source
      "hrsh7th/cmp-path",         -- Path completion source
      "L3MON4D3/LuaSnip",         -- Snippet engine
      "saadparwaiz1/cmp_luasnip", -- Snippet completion source
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- Use LuaSnip for snippet expansion
          end,
        },
        mapping = {
          ["<C-Space>"] = cmp.mapping.complete(),            -- Trigger completion
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
          ["<Up>"] = cmp.mapping.select_prev_item(),         -- Navigate to the previous item
          ["<Down>"] = cmp.mapping.select_next_item(),       -- Navigate to the next item
          ["<Right>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }), -- Jump to the next snippet placeholder
          ["<Left>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }), -- Jump to the previous snippet placeholder
          -- ["<Tab>"] = cmp.mapping(function(fallback)
          -- 	if cmp.visible() then
          -- 		cmp.select_next_item()
          -- 	elseif luasnip.expand_or_jumpable() then
          -- 		luasnip.expand_or_jump()
          -- 	else
          -- 		fallback()
          -- 	end
          -- end, { "i", "s" }), -- Navigate completion and snippets
          -- ["<S-Tab>"] = cmp.mapping(function(fallback)
          -- 	if cmp.visible() then
          -- 		cmp.select_prev_item()
          -- 	elseif luasnip.jumpable(-1) then
          -- 		luasnip.jump(-1)
          -- 	else
          -- 		fallback()
          -- 	end
          -- end, { "i", "s" }), -- Navigate completion and snippets backward
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- LSP completions
          { name = "luasnip" },  -- Snippet completions
          { name = "buffer" },   -- Buffer completions
          { name = "path" },     -- Path completions
        }),
      })
    end,
  },
}
