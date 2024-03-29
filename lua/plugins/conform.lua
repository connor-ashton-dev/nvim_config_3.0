return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = {
			timeout_ms = 3000,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			go = { "gofmt" },
			python = { "black" },
			rust = { "rustfmt" },
		},

		formatters = {
			rustfmt = {
				args = { "--edition=2021" },
			},
		},
	},
}
