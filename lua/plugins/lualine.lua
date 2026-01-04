return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lualine = require("lualine")
		-- configure lualine with modified theme

		lualine.setup({
			options = {
				-- theme = "dracula-nvim",
				theme = "auto",
				disabled_filetypes = {
					statusline = {
						"neo-tree",
						"dashboard",
						"alpha",
						"starter",
						"fugitive",
						"grug-far",
						"snacks_terminal",
					},
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = {},
				lualine_x = {},
				lualine_y = { "diagnostics" },
				lualine_z = { "filename" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
