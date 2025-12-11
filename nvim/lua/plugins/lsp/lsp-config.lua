return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local keymap = vim.keymap
		local lsp = vim.lsp
		-- local bufopts = { noremap = true, silent = true }

		-- LspAttach keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "grr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Show LSP definitions"
				keymap.set("n", "grd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gri", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "grt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>cr", lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Hover docs"
				keymap.set("n", "K", lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>cs", ":LspRestart<CR>", opts)
			end,
		})

		-- completion capabilities
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Base memory limit for Node-based LSPs
		local NODE_MAX_MEM = "16384" -- 16 GB

		vim.lsp.config("vtsls", {
			capabilities = capabilities,
			root_markers = { "tsconfig.json", "package.json", ".git" },
			settings = {
				typescript = { tsserver = { maxTsServerMemory = tonumber(NODE_MAX_MEM) } },
				vtsls = {
					enableMoveToFileCodeAction = true,
					experimental = { completion = { enableServerSideFuzzyMatch = true } },
				},
			},
		})

		-- enable servers
		-- vim.lsp.enable("vtsls")
		-- vim.lsp.enable({ "lua_ls", "astro", "graphql" })

		-- diagnostic signs
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
	end,
}
