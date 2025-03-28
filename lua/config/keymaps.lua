vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- Window management
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split Window Vertically" })
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })

-- Movement
keymap.set("n", "<C-h>", "<Cmd>wincmd h<CR>", { desc = "Move Cursor to Left Window" })
keymap.set("n", "<C-j>", "<Cmd>wincmd j<CR>", { desc = "Move Cursor to Bottom Window" })
keymap.set("n", "<C-k>", "<Cmd>wincmd k<CR>", { desc = "Move Cursor to Top Window" })
keymap.set("n", "<C-l>", "<Cmd>wincmd l<CR>", { desc = "Move Cursor to Right Window" })

-- Buffer navigation
keymap.set("n", "H", "<Cmd>bprevious<CR>", { desc = "Move to Previous Buffer", noremap = true, silent = true })
keymap.set("n", "L", "<Cmd>bnext<CR>", { desc = "Move to Next Buffer", noremap = true, silent = true })

-- Save buffer
keymap.set("n", "<C-S>", "<Cmd>write<CR>", { desc = "Save Buffer" })

local function delete_buffers(direction)
	local current_buf = vim.api.nvim_get_current_buf()
	local buffers = vim.api.nvim_list_bufs()
	local current_index = nil

	-- Find the index of the current buffer
	for i, buf in ipairs(buffers) do
		if buf == current_buf then
			current_index = i
			break
		end
	end

	if not current_index then
		return
	end
	local start_idx, end_idx
	if direction == "left" then
		start_idx = 1
		end_idx = current_index - 1
	elseif direction == "right" then
		start_idx = current_index + 1
		end_idx = #buffers
	else
		return
	end

	for i = start_idx, end_idx do
		local buf = buffers[i]
		if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
			vim.cmd("bdelete " .. buf)
		end
	end
end

-- Delete buffers to the right of the current buffer
keymap.set("n", "<leader>br", function()
	delete_buffers("right")
end, { desc = "Delete Buffers to the Right" })

-- Delete buffers to the left of the current buffer
keymap.set("n", "<leader>bl", function()
	delete_buffers("left")
end, { desc = "Delete Buffers to the Left" })

-- File path copying
keymap.set("n", "<leader>fya", function()
	vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy Absolute File Path to Clipboard" })

keymap.set("n", "<leader>fyr", function()
	vim.fn.setreg("+", vim.fn.expand("%:p:."))
end, { desc = "Copy Relative File Path to Clipboard" })

keymap.set("n", "<leader>fyn", function()
	vim.fn.setreg("+", vim.fn.expand("%:t"))
end, { desc = "Copy Filename to Clipboard" })
