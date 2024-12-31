return {
	"nvim-flutter/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
	},
	opts = {
		widget_guides = {
			enabled = true,
		},
		dev_tools = {
			autostart = true,
			auto_open_browser = true,
		},
	},
	keys = {
		{ "<leader>fe", "<cmd>FlutterEmulators<cr>" },
		{ "<leader>fs", "<cmd>FlutterRun<cr>" },
		{ "<leader>fr", "<cmd>FlutterReload<cr>" },
		{ "<leader>fR", "<cmd>FlutterRestart<cr>" },
		{ "<leader>frn", "<cmd>FlutterRename<cr>" },
	},
}
