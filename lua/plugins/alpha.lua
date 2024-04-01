return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local status_ok, alpha = pcall(require, "alpha")
		if not status_ok then
			return
		end

		local dashboard = require("alpha.themes.dashboard")
		local date_time = os.date("%Y-%m-%d %H:%M:%S")
		local formatted_date = " " .. os.date("%A, %B %d")

		local function get_battery_macos()
			local handle = io.popen("pmset -g batt")
			local result = handle:read("*a")
			handle:close()

			local percentage = result:match("([0-9]+%%)")
			if percentage then
				return "󰂂 " .. percentage
			else
				return "Unable to fetch battery info"
			end
		end

		dashboard.section.header.val = {
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                     ",
		}

		dashboard.section.buttons.val = {
			-- ["e"] = { ":NvimTreeToggle<CR>", "Explorer" },
			dashboard.button("f", "  Search", ":Telescope find_files <CR>"),
			dashboard.button(
				"e",
				"  Explorer",
				":lua require('neo-tree.command').execute({ toggle = true, dir = vim.uv.cwd() }) <CR>"
			),
			-- dashboard.button("p", "󰣪  Project", ":Telescope projects <CR>"),
			dashboard.button("r", "󰥔  Recents", ":Telescope oldfiles <CR>"),
			dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
			dashboard.button("q", "󱠡  Quit Neovim", ":qa<CR>"),
		}

		-- dashboard.section.footer.val = {
		-- 	"",
		-- 	"",
		-- 	"",
		-- 	-- formatted_date .. " | " .. get_battery_macos() .. " | " .. get_weather("Provo", "0074c776238afb9f7277773cc5cbc742"),
		-- 	formatted_date
		-- 		.. " | "
		-- 		.. get_battery_macos(),
		-- }
		-- dashboard.section.buttons.opts.hl = "Number"
		-- dashboard.section.header.opts.hl = "Type"
		-- dashboard.section.footer.opts.hl = "Number"

		dashboard.opts.opts.noautocmd = true
		-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
		alpha.setup(dashboard.opts)
	end,
}
