return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")

			-- Set up keymaps with descriptions
			vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<C-S-f>", builtin.live_grep, { desc = "Search text in files (live grep)" })
			vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, { desc = "Find recent files" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "List open buffers" })

			-- Custom action to delete buffers
			require("telescope").setup({
				defaults = {
					path_display = function(_, path)
						local filename = vim.fn.fnamemodify(path, ":t")
						local filepath = vim.fn.fnamemodify(path, ":h")
						return string.format("%s\t-\t%s", filename, filepath)
					end,
					preview = false,
					mappings = {
						i = {
							["<C-d>"] = actions.delete_buffer, -- Delete buffer in insert mode
						},
						n = {
							["<C-d>"] = actions.delete_buffer, -- Delete buffer in normal mode
						},
					},
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- Customize fzf colors
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
