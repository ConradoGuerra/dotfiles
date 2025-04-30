return {
	"folke/noice.nvim",
	opts = {
		cmdline = {
			enabled = true,
			view = "cmdline_popup",
		},
		popupmenu = {
			enabled = true,
			backend = "nui",
		},
		messages = { enabled = false },
		notify = { enabled = false },
		lsp = {
			progress = { enabled = false },
			hover = { enabled = false },
			signature = { enabled = false },
		},
		routes = {
			{ filter = { event = "msg_show" }, opts = { skip = true } },
		},
	},
}
