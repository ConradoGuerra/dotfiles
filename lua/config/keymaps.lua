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
keymap.set("n", "H", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Move to Previous Buffer (Tabline Order)" })
keymap.set("n", "L", "<Cmd>BufferLineCycleNext<CR>", { desc = "Move to Next Buffer (Tabline Order)" })

-- Buffer management
keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Pin Current Buffer" })
keymap.set("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
keymap.set("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
keymap.set("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })

-- Save buffer
keymap.set("n", "<C-S>", "<Cmd>write<CR>", { desc = "Save Buffer" })

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
