return {
	"utilyre/barbecue.nvim",
	event = { "BufReadPre", "BufNewFile" },
	name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	opts = {
		theme = "tokyonight",
		-- configurations go here
	},
}
