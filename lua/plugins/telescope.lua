return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false, -- telescope did only one release, so use HEAD for now
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					-- prompt_prefix = " ",
					-- selection_caret = ">",
					path_display = { "smart" },
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
						-- theme = "dropdown",
						-- previewer = false,
						-- no_ignore = true,
						hidden = true,
						prompt_title = "All Files",
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
						theme = "ivy",
						-- previewer = true,
						prompt_title = "Variables",
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
}
