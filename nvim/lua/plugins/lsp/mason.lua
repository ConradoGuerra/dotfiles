return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap",
	},
	config = function()
		local mason = require("mason")

		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		local mason_dap = require("mason-nvim-dap")

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
			ensure_installed = {
				"ts_ls",
				"vtsls",
				"eslint",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"eslint_d",
			},
		})

		mason_dap.setup({
			ensure_installed = { "go", "node" },
			automatic_setup = true,
			automatic_installation = true,
		})
	end,
}
