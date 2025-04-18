return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"mfussenegger/nvim-dap",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")
		local mason_dap = require("mason-nvim-dap")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"cssls",
				"gopls",
				"graphql",
				"html",
				"lua_ls",
				"ruby_lsp",
				"tailwindcss",
				"ts_ls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"eslint_d",
				"prettier", -- prettier formatter
				"rubocop",
				"stylua", -- lua formatter
			},
		})

		mason_dap.setup({
			ensure_installed = { "go", "node", "delve" }, -- Example debuggers
			automatic_setup = true,
			automatic_installation = true,
		})
	end,
}
