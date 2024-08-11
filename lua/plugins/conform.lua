return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},

		notify_on_error = false,
		notify_no_formatters = false,

		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier" },
			html = { "prettier" },
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
