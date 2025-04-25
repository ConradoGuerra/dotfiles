return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"moll/vim-bbye",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers", -- set to "tabs" to only show tabpages instead
				themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
				numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
				close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
				buffer_close_icon = "",
				close_icon = "",
				path_components = 1, -- Show only the file name without the directory
				modified_icon = "●",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 30,
				max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
				tab_size = 21,
				diagnostics = "nvim_lsp", -- show LSP diagnostics
				diagnostics_update_in_insert = false,
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return icon .. count
				end,
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
				separator_style = { "│", "│" }, -- | "thick" | "thin" | { 'any', 'any' },
				enforce_regular_tabs = true,
				always_show_bufferline = true,
				show_tab_indicators = false,
				offsets = {
					{
						filetype = "neo-tree",
						highlight = "Directory",
						text_align = "left",
						separator = true,
					},
				},
				indicator = { icon = "▎", style = "icon" },
				icon_pinned = "󰐃",
				sort_by = "insert_at_end",
			},
			highlights = {
				-- example: change the selected buffer’s background
				buffer_selected = { guibg = "#282c34", guifg = "#51afef", gui = "bold" },
			},
		})
	end,
}
