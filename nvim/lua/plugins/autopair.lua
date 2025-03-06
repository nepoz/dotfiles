return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" },
	configure = true,
	opts = {
		enable_close_on_slash = true,
	},
}
