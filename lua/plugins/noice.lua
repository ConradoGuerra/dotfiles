return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"rcarriga/nvim-notify",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("noice").setup({
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			messages = {
				enabled = true, -- keep this enabled for other UI elements
				view = "messages", 
				view_error = "notify", -- view for errors
				view_warn = "notify", -- view for warnings
				view_history = "messages", -- view for :messages
				view_search = false, -- disable default search count display
			},
			routes = {
				-- Skip all msg_show messages (effectively hiding all notifications)
				{
					filter = {
						event = "msg_show",
					},
					opts = { skip = true },
				},
			},
		})
	end,
}
