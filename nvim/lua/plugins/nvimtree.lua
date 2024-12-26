return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VimEnter",
	config = function()
		require("nvim-tree").setup({
			view = {
				side = "right",
			},
		})
		vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })
		vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#000000" })
	end,
	opts = {
		view = {
			side = "right",
		},
	},
	keys = {
		{ "<leader>pv", "<cmd>NvimTreeToggle<cr>" },
	},
}
