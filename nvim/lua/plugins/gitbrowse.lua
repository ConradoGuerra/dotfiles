return {
	"Morozzzko/git_browse.nvim",
	config = function()
		local git = require("git_browse")
		local map = vim.keymap.set

		map({ "n", "x" }, "<leader>go", git.browse, { desc = "Git Browse (open file)" })
		map({ "n", "x" }, "<leader>gi", git.blame, { desc = "Git Browse (blame line)" })
	end,
}
