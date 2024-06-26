return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false, -- telescope did only one release, so use HEAD for now
		dependencies = {
			{
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					-- prompt_prefix = " ",
					-- selection_caret = ">",
					path_display = { "absolute" },
				},

				pickers = {
					find_files = {
						find_command = {
							"rg",
							"--files",
							"-g",
							"!.git",
							"-g",
							"!node_modules/*",
							"-g",
							"!target/*",
						},
						theme = "dropdown",
						previewer = false,
						-- no_ignore = true,
						hidden = true,
						prompt_title = "Find Files",
					},

					git_files = {
						theme = "dropdown",
						previewer = false,
						prompt_title = "Git Files",
					},
					spell_suggest = {
						theme = "cursor",
						-- previewer = false,
						prompt_title = "Spelling Suggestions",
					},

					treesitter = {
						-- theme = "ivy",
						previewer = true,
						prompt_title = "Variables",
					},
					extensions = {
						fzf = {
							fuzzy = true, -- false will only do exact matching
							override_generic_sorter = true, -- override the generic sorter
							override_file_sorter = true, -- override the file sorter
							case_mode = "smart_case", -- or "ignore_case" or "respect_case"
							-- the default case_mode is "smart_case"
						},
					},
				},
			})
		end,
	},
}
