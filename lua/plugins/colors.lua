return {
	-- --INFO: CATPUCCIN
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- },

	--INFO: DRACULA
	-- return {
	-- 	"Mofiqul/dracula.nvim",
	-- 	opts = {
	-- 		transparent_bg = false, -- default false
	-- 	},
	-- }

	-- INFO: ROSE PINE
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	opts = {
	-- 		styles = {
	-- 			bold = true,
	-- 			italic = false,
	-- 			transparency = false,
	-- 		},
	-- 	},
	-- },

	-- NightFox
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- },

	-- Kanagawa
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- },

	--INFO: GRUVBOX MATERIAL
	-- return {
	-- 	"sainnhe/gruvbox-material",
	-- }

	--INFO: GRUVBOX
	-- return {
	-- 	{
	-- 		"ellisonleao/gruvbox.nvim",
	-- 		priority = 1000,
	-- 		-- config = true,
	-- 		-- opts = {
	-- 		-- 	terminal_colors = true, -- add neovim terminal colors
	-- 		-- 	undercurl = true,
	-- 		-- 	underline = true,
	-- 		-- 	bold = true,
	-- 		-- 	italic = {
	-- 		-- 		strings = true,
	-- 		-- 		emphasis = true,
	-- 		-- 		comments = true,
	-- 		-- 		operators = false,
	-- 		-- 		folds = true,
	-- 		-- 	},
	-- 		-- 	strikethrough = true,
	-- 		-- 	invert_selection = false,
	-- 		-- 	invert_signs = false,
	-- 		-- 	invert_tabline = false,
	-- 		-- 	invert_intend_guides = false,
	-- 		-- 	inverse = true, -- invert background for search, diffs, statuslines and errors
	-- 		-- 	contrast = "", -- can be "hard", "soft" or empty string
	-- 		-- 	palette_overrides = {},
	-- 		-- 	overrides = {},
	-- 		-- 	dim_inactive = false,
	-- 		-- 	transparent_mode = false,
	-- 		-- },
	-- 	},
	-- }
	-- return {
	-- 	"scottmckendry/cyberdream.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = function(_, opts)
	-- 		opts.transparent = true
	-- 		opts.italic_comments = true
	-- 	end,
	-- }

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				light_style = "day", -- The theme is used when the background is set to light
				transparent = false, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
				on_colors = function(colors)
					colors.bg_statusline = colors.none -- or "NONE"
				end,
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = false },
					keywords = { italic = false },
					functions = { italic = false },
					variables = { italic = false },
					-- Background styles. Can be "dark", "transparent" or "normal"
				},
				-- sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
				-- day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				-- hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
				-- dim_inactive = false, -- dims inactive windows
				-- lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
				--
				-- --- You can override specific color groups to use other groups or a hex color
				-- --- function will be called with a ColorScheme table
				-- ---@param colors ColorScheme
				-- on_colors = function(colors) end,
				--
				-- --- You can override specific highlights to use other groups or a hex color
				-- --- function will be called with a Highlights and ColorScheme table
				-- ---@param highlights Highlights
				-- ---@param colors ColorScheme
				-- on_highlights = function(highlights, colors) end,
			})
		end,
	},
}
