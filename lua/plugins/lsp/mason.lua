return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- LSP servers
					"css-lsp",
					"gopls",
					"graphql-language-service-cli",
					"html-lsp",
					"lua-language-server",
					"ruby-lsp",
					"tailwindcss-language-server",
					"typescript-language-server",
					-- Formatters and linters
					"eslint_d",
					"prettier",
					"rubocop",
					"stylua",
				},
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "go", "node", "delve" },
				automatic_setup = true,
				automatic_installation = true,
			})
		end,
	},
}
