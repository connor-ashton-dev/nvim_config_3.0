return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		default_file_explorer = true,

		keymaps = {
			["q"] = {
				function()
					require("oil").close({ exit_if_last_buf = true })
				end,
				desc = "Quit",
			},
			["<leader>o"] = {
				function()
					local cwd = require("oil").get_current_dir()
					os.execute("open " .. cwd)
				end,
				desc = "Open finder in cwd",
			},
			["<CR>"] = "actions.select",
			["."] = "actions.select",
			["<BS>"] = "actions.parent",
			["H"] = "actions.toggle_hidden",
			["U"] = {
				function()
					require("oil").discard_all_changes()
				end,
				desc = "Discard all changes",
			},
			["<C-y>"] = "actions.yank_entry",
		},
	},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
