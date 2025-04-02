return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			auto_install = true,
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"javascript",
				"typescript",
				"rust",
				"go",
				"python",
				"dart",
				"html",
				"powershell",
				"zig",
				"astro",
				"c_sharp",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			autotag = {
				enable = true,
			},
		})
	end,
}
