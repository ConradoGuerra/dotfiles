vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set wrap")
vim.g.mapleader = " "
vim.api.nvim_create_autocmd("FileType", {
  pattern = "diff",
  callback = function()
    vim.opt.wrap = true
  end,
})
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.number = true
-- Decrease window size
vim.keymap.set("n", "<C-->", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<leader>-", "<Cmd>vertical resize -5<CR>", { desc = "Resize window -5" })

-- Increase window size
vim.keymap.set("n", "<leader>=", "<Cmd>vertical resize +5<CR>", { desc = "Resize window +5" })
vim.keymap.set("n", "<C-=>", ":resize +2<CR>", { desc = "Increase window height" })
--
-- Copy to clipboard
vim.keymap.set("v", "<C-c>", [["+y]])

-- Movement
vim.keymap.set("n", "<C-h>", "<Cmd>wincmd h<CR>", { desc = "Move cursor to left window" })
vim.keymap.set("n", "<C-j>", "<Cmd>wincmd j<CR>", { desc = "Move cursor to bottom window" })
vim.keymap.set("n", "<C-k>", "<Cmd>wincmd k<CR>", { desc = "Move cursor to top window" })
vim.keymap.set("n", "<C-l>", "<Cmd>wincmd l<CR>", { desc = "Move cursor to right window" })
vim.keymap.set("n", "<C-S>", "<Cmd>write<CR>", { desc = "Save buffer" })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
