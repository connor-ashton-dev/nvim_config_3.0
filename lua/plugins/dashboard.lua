return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "hyper",
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
					{
						action = "Telescope find_files",
						group = "@property",
						desc = " Find File",
						icon = " ",
						key = "f",
					},
					{
						action = "lua require('neo-tree.command').execute({ toggle = true, position = 'right', reveal = true })",
						group = "Label",
						desc = " Explorer",
						icon = " ",
						key = "e",
					},
					{
						action = "Lazy",
						desc = " Lazy",
						group = "DiagnosticHint",
						icon = "󰒲 ",
						key = "l",
					},
					{
						action = "qa",
						group = "Number",
						desc = " Quit",
						icon = " ",
						key = "q",
					},
				},
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
