return {
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = true,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			return {
				timeout_ms = 3000,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			sh = { "shfmt" },
			html = { "djlint" },
			go = { "gofmt", "goimports" },
			c = { "clang_format" },
			lua = { "stylua" },
			astro = { "prettier" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			rust = { "rustfmt" },
			cpp = { "clang_format" },
			toml = { "taplo" },
			docker = { "dockerls" },
			-- Conform can also run multiple formatters sequentially
			python = {
				-- To fix auto-fixable lint errors.
				"ruff_fix",
				-- To run the Ruff formatter.
				"ruff_format",
				-- To organize the imports.
				"ruff_organize_imports",
			},
			--
			-- You can use a sub-list to tell conform to run *until* a formatter
			-- is found.
			-- javascript = { { "prettierd", "prettier" } },
		},
		formatters = {
			clang_format = {
				prepend_args = { "--style=file", "--fallback-style=LLVM" },
			},
			shfmt = {
				prepend_args = { "-i", "4" },
			},
			rustfmt = {
				args = { "--edition=2021" },
			},
		},
	},
}
