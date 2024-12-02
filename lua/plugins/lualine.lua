return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				-- theme = "dracula-nvim",
				theme = "auto",
				disabled_filetypes = { statusline = { "neo-tree", "dashboard", "alpha", "starter" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {},
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
