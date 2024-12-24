return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find files (all)" },
		{ "<leader>fb", "<cmd>Telescope buffers hidden=true<cr>", desc = "Find buffers" },
		{ "<leader>fg", "<cmd>Telescope git_files hidden=true<cr>", desc = "Find git files" },
	},
}
