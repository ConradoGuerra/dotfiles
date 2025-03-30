return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						width = 0.9, -- 90% of the editor width
						height = 0.95, -- 95% of the editor height
						preview_height = 0.5, -- 50% of the height for preview
						prompt_position = "top", -- input at the top
					},
				},
				path_display = { "relative" }, -- Just show relative path
			},
			pickers = {
				lsp_references = {
					layout_config = {
						vertical = {
							prompt_position = "top", -- Input at the top
							preview_height = 0.5, -- 50% for preview
							mirror = true, -- Preview below results
						},
					},
					path_display = { "relative" }, -- Just show relative path
					show_line = false, -- Hide line numbers
					trim_text = true, -- Remove surrounding code preview
				},
			},
		})
		telescope.load_extension("fzf")
	end,
}
