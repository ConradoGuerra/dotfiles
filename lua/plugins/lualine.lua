return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		-- Custom component for search count
		local search_count = {
			function()
				local search = require("noice").api.status.search.get()
				return search and search or ""
			end,
			cond = function()
				return package.loaded["noice"] and require("noice").api.status.search.has()
			end,
			color = { fg = "#7dcfff" }, -- Customize color as needed
		}

		-- Get noice mode (replaces the deprecated statusline.mode.get)
		local noice_mode = {
			function()
				return require("noice").api.status.mode.get()
			end,
			cond = function()
				return package.loaded["noice"] and require("noice").api.status.mode.has()
			end,
			color = { fg = "#ff9e64" },
		}

		lualine.setup({
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
					},
				},
				lualine_x = {
					search_count, -- Add search count component
					noice_mode, -- Using the updated API
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
