return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon = " ", key = "g", desc = "Lazygit", action = ":lua Snacks.lazygit()" },
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
		},
		explorer = { enabled = true },
		input = { enabled = true },
		picker = {
			enabled = true,
			layout = {
				preset = "telescope",
			},
			sources = {
				files = {
					cmd = "rg",
					args = {
						"--files",
						"-g",
						"!.git",
						"-g",
						"!node_modules/*",
						"-g",
						"!target/*",
					},
					hidden = true,
				},
			},
		},
		notifier = {
			enabled = true,
			filter = function(notif)
				if notif.msg then
					return not (notif.msg:find("Neo%-tree") or notif.msg:find("neo%-tree"))
				end
				if notif.title then
					return not (notif.title:find("Neo%-tree") or notif.title:find("neo%-tree"))
				end
				return true
			end,
		},
		lazygit = {
			enabled = true,
			win = {
				position = "float",
				backdrop = false,
				width = 0,
				height = 0,
				border = "none",
			},
		},
	},
	keys = {
		-- Top Pickers & Explorer
		{
			"<leader><space>",
			function()
				Snacks.picker.files()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},

		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Grep",
		},
		{
			"<leader>ft",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.spelling()
			end,
			desc = "Spelling",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>n",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>sp",
			function()
				Snacks.picker()
			end,
			desc = "Pickers",
		},
		{
			"<leader>t",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>sm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		-- {
		-- 	"<leader>vv",
		-- 	function()
		-- 		Snacks.picker.treesitter()
		-- 	end,
		-- 	nowait = true,
		-- 	desc = "Treesitter",
		-- },
	},
}
