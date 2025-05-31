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
		local action_state = require("telescope.actions.state")
		local builtin = require("telescope.builtin")
		local function send_to_qf_and_open(prompt_bufnr)
			local current_picker = action_state.get_current_picker(prompt_bufnr)
			if not current_picker then
				return
			end

			actions.send_selected_to_qflist(prompt_bufnr)

			vim.schedule(function()
				vim.cmd("copen")
			end)
		end
		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-f>"] = actions.to_fuzzy_refine,
						["<C-q>"] = send_to_qf_and_open,
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
					},
					n = {
						["<C-f>"] = actions.to_fuzzy_refine,
						["<C-q>"] = send_to_qf_and_open,
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
					},
				},
				layout_strategy = "vertical",
				path_display = { "relative" }, -- Just show relative path
			},
			pickers = {
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
			builtin.grep_string({ search = word })
		end, { desc = "Find word under cursor" })

		-- Search category
		vim.keymap.set("n", "<leader>sa", builtin.autocommands, { desc = "Auto Commands" })
		vim.keymap.set("n", "<leader>sb", builtin.current_buffer_fuzzy_find, { desc = "Buffer Search" })
		vim.keymap.set("n", "<leader>sc", builtin.command_history, { desc = "Command History" })
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Help Tags" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Keymaps" })
		vim.keymap.set("n", "<leader>sr", builtin.registers, { desc = "Registers" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Telescope Pickers" })
		vim.keymap.set("n", "<leader>st", builtin.colorscheme, { desc = "Colorschemes" })

		-- LSP category
		vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, { desc = "Goto Definition" })
		vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "References" })
		vim.keymap.set("n", "<leader>li", builtin.lsp_implementations, { desc = "Implementations" })
		vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "Document Symbols" })
		vim.keymap.set("n", "<leader>lw", builtin.lsp_workspace_symbols, { desc = "Workspace Symbols" })
		vim.keymap.set("n", "<leader>lS", builtin.lsp_dynamic_workspace_symbols, { desc = "Dynamic Workspace Symbols" })
	end,
}
