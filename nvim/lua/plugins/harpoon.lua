return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("harpoon"):setup()
	end,
	keys = {
		{"<leader>a", function() require("harpoon"):list():add() end, desc = "Add a file to the pool"},
		      { "<leader>e", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
		{"<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon!"},
		{"<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon!"},
		{"<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon!"},
		{"<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon!"},
	}

}
