return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			-- enable syntax highlighting
			treesitter.setup({
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true },
				-- enable autotagging (w/ nvim-ts-autotag plugin)
				autotag = {
					enable = true,
				},
				-- ensure these language parsers are installed
				ensure_installed = {
					-- essential for neovim/plugins
					"lua",
					"vim",
					"vimdoc",
					"query",
					"regex",
					"markdown",
					"markdown_inline",
					-- web dev
					"typescript",
					"tsx",
					"javascript",
					"html",
					"css",
					"json",
					"jsonc",
					"svelte",
					"astro",
					"prisma",
					-- other languages from LSP config
					"python",
					"go",
					"rust",
					"c",
					"sql",
					-- config files
					"yaml",
					"toml",
					"dockerfile",
					"bash",
					"gitignore",
				},
				incremental_selection = {
					enable = false,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})

			-- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
			require("ts_context_commentstring").setup({})
		end,
	},
}
