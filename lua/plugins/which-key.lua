return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		map = vim.keymap.set, -- keymap.set function to use
		preset = "helix",
		which_key = true, -- integrate with which-key to show enabled/disabled icons and colors
		notify = true, -- show a notification when toggling
		-- icons for enabled/disabled states
		icon = {
			enabled = " ",
			disabled = " ",
		},
		-- colors for enabled/disabled states
		color = {
			enabled = "green",
			disabled = "yellow",
		},
		wk_desc = {
			enabled = "Disable ",
			disabled = "Enable ",
		},
	},
}
