return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		treesitter.setup({
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = { enable = true },
			autotag = {
				enable = true,
			},
			ensure_installed = {
				"bash",
				"css",
				"dockerfile",
				"gitignore",
				"go",
				"graphql",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"ruby",
				"terraform",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
		})
	end,
}
