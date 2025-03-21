return {
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = function()
			return {
				indent = {
					char = "│",
					tab_char = "│",
				},
				scope = { show_start = false, show_end = false },
				exclude = {
					filetypes = {
						"Trouble",
						"alpha",
						"dashboard",
						"help",
						"mason",
						"neo-tree",
						"notify",
						"toggleterm",
						"trouble",
					},
				},
			}
		end,
		main = "ibl",
	},
}
