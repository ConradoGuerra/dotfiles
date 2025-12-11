return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-f>"] = actions.to_fuzzy_refine,
						["<C-j>"] = function(prompt_bufnr)
							for _ = 1, 5 do -- Jump exactly 5 items
								actions.move_selection_next(prompt_bufnr)
							end
						end,
						["<C-k>"] = function(prompt_bufnr)
							for _ = 1, 5 do -- Jump up exactly 5 items
								actions.move_selection_previous(prompt_bufnr)
							end
						end,
						["<C-c>"] = actions.delete_buffer,
					},
					n = {
						["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-f>"] = actions.to_fuzzy_refine,
						["<C-j>"] = function(prompt_bufnr)
							for _ = 1, 5 do -- Jump exactly 5 items
								actions.move_selection_next(prompt_bufnr)
							end
						end,
						["<C-k>"] = function(prompt_bufnr)
							for _ = 1, 5 do -- Jump up exactly 5 items
								actions.move_selection_previous(prompt_bufnr)
							end
						end,
						["<C-c>"] = actions.delete_buffer,
					},
				},
				layout_strategy = "vertical",
				path_display = { "relative" }, -- Just show relative path
			},
			pickers = {
				buffers = {
					sort_mru = true, -- most recent first
				},
				lsp_definitions = {
					path_display = { "relative" }, -- Just show relative path
					show_line = false, -- Hide line numbers
					trim_text = true, -- Remove surrounding code preview
				},
				lsp_implementations = {
					path_display = { "relative" }, -- Just show relative path
					show_line = false, -- Hide line numbers
					trim_text = true, -- Remove surrounding code preview
				},
				lsp_references = {
					path_display = { "relative" }, -- Just show relative path
					show_line = false, -- Hide line numbers
					trim_text = true, -- Remove surrounding code preview
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")

		-- Core keymaps
		vim.keymap.set("n", "<leader><space>", function()
			builtin.find_files()
		end, { desc = "Find Files" })
		vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Buffers" })
		vim.keymap.set("n", "<leader>/", function()
			builtin.live_grep({
				additional_args = { "--hidden" },
				cwd = vim.fn.getcwd(),
			})
		end, { desc = "Grep (with hidden)" })
		vim.keymap.set("n", "<leader>:", builtin.command_history, { desc = "Command History" })

		-- Find category
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
		vim.keymap.set("n", "<leader>fc", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Find Config File" })
		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({
				hidden = true,
				cwd = vim.fn.getcwd(),
			})
		end, { desc = "Find Files (with hidden)" })
		vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find Git Files" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
		vim.keymap.set("n", "<leader>fm", function()
			builtin.marks({
				previewer = true,
				show_line = true,
				layout_config = { width = 0.9 },
			})
		end, { desc = "Find Vim Marks" })

		vim.keymap.set("n", "<leader>fw", function()
			local word = vim.fn.expand("<cword>")
			builtin.live_grep({
				default_text = word,
				additional_args = { "--hidden" },
			})
			-- Move cursor to end of prompt after opening
			vim.defer_fn(function()
				vim.cmd("startinsert!")
			end, 10)
		end, { desc = "Find word (can add regex)" })

		-- Search category
		vim.keymap.set("n", "<leader>sa", builtin.autocommands, { desc = "Auto Commands" })
		vim.keymap.set("n", "<leader>sb", builtin.current_buffer_fuzzy_find, { desc = "Buffer Search" })
		vim.keymap.set("n", "<leader>sc", builtin.command_history, { desc = "Command History" })
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Help Tags" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Keymaps" })
		vim.keymap.set("n", "<leader>sr", builtin.registers, { desc = "Registers" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Telescope Pickers" })
		vim.keymap.set("n", "<leader>st", builtin.colorscheme, { desc = "Colorschemes" })
	end,
}
