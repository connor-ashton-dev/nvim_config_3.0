return {
	{
		"neovim/nvim-lspconfig",
		-- event = { "BufReadPost", "BufNewFile" },
		-- cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
			"hrsh7th/cmp-nvim-lsp",
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- local util = require("lspconfig/util")

			lspconfig.pyright.setup({
				capabilities = capabilities,
			})

			lspconfig.prismals.setup({
				capabilities = capabilities,
			})

			lspconfig.sourcekit.setup({
				cmd = { "/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp" },
				capabilities = capabilities,
			})

			lspconfig.htmx.setup({
				capabilities = capabilities,
			})

			lspconfig.dockerls.setup({
				capabilities = capabilities,
			})

			lspconfig.marksman.setup({
				capabilities = capabilities,
			})

			lspconfig.emmet_language_server.setup({
				capabilities = capabilities,
			})

			lspconfig.svelte.setup({
				capabilities = capabilities,
			})

			lspconfig.cssls.setup({
				capabilities = capabilities,
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
			})

			lspconfig.sqlls.setup({
				cmd = { "sql-language-server", "up", "--method", "stdio" },
				capabilities = capabilities,
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
			})

			lspconfig.tsserver.setup({
				capabilities = capabilities,
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = false
				end,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
					},
				},
			})
			lspconfig.tailwindcss.setup({ capabilities = capabilities })
			lspconfig.pyright.setup({ capabilities = capabilities })
			lspconfig.jsonls.setup({ capabilities = capabilities })

			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						-- Other Settings ...
						procMacro = {
							ignored = {
								leptos_macro = {
									-- optional: --
									-- "component",
									"server",
								},
							},
						},
					},
				},
			})

			local signs = {
				{ name = "DiagnosticSignError", text = "" },
				{ name = "DiagnosticSignWarn", text = "" },
				{ name = "DiagnosticSignHint", text = "󰍉" },
				{ name = "DiagnosticSignInfo", text = " " },
			}

			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
			end

			local config = {
				-- disable virtual text
				virtual_text = true,
				-- show signs
				signs = {
					active = signs,
				},
				update_in_insert = true,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			}

			vim.diagnostic.config(config)

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = {}
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "H", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "gn", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, opts)
					--get previous diagnostic
					-- p = { "<cmd>lua vim.diagnostic.goto_prev({float = true})<CR>", "Previous Diagnostic" },
					-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					-- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					-- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
					-- vim.keymap.set("n", "<space>wl", function()
					--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					-- end, opts)
					--vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
					-- vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<space>fd", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})
		end,
	},
}
