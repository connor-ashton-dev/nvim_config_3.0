return {
	"m4xshen/hardtime.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	opts = {
		enabled = false,
		disabled_filetypes = { "qf", "netrw", "neo-tree", "lazy", "mason", "oil", "dashboard" },
	},
}
