return {
	"williamboman/mason.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"pyright",
				"ts_ls",
				"lua_ls",
				"jsonls",
				"java_language_server",
				"gopls",
				"tailwindcss",
				"svelte",
				"cssls",
				"typos_lsp",
				"sqlls",
				"denols",
				"dockerls",
				"prismals",
				"clangd",
				"htmx",
				"marksman",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"black",
				"eslint_d",
				-- "gofmt",
				"flake8",
			},
		})
	end,
}
