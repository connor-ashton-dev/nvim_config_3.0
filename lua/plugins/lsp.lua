return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		-- cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
			"saghen/blink.cmp",
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local border = "rounded"

			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
			}

			local function on_attach(client, bufnr)
				-- if vim.lsp.inlay_hint then
				-- 	vim.lsp.inlay_hint.enable()
				-- end
			end

			local servers = {
				"taplo",
				"ruff",
				"pyright",
				"prismals",
				"zls",
				"dockerls",
				"astro",
				"marksman",
				"emmet_language_server",
				"svelte",
				"cssls",
				"clangd",
				"gopls",
				"templ",
				"tailwindcss",
				"jsonls",
			}

			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					handlers = handlers,
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end

			-- Special configurations
			lspconfig.sourcekit.setup({
				cmd = { "/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp" },
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.vtsls.setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
				end,
				opts = {
					-- make sure mason installs the server
					servers = {
						--- @deprecated -- tsserver renamed to ts_ls but not yet rel eased, so keep this for now
						--- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
						tsserver = {
							enabled = false,
						},
						ts_ls = {
							enabled = false,
						},
						vtsls = {
							-- explicitly add default filetypes, so that we can extend
							-- them in related extras
							filetypes = {
								"javascript",
								"javascriptreact",
								"javascript.jsx",
								"typescript",
								"typescriptreact",
								"typescript.tsx",
							},
							settings = {
								complete_function_calls = true,
								vtsls = {
									enableMoveToFileCodeAction = true,
									autoUseWorkspaceTsdk = true,
									experimental = {
										maxInlayHintLength = 30,
										completion = {
											enableServerSideFuzzyMatch = true,
										},
									},
								},
								typescript = {
									updateImportsOnFileMove = { enabled = "always" },
									suggest = {
										completeFunctionCalls = true,
									},
									inlayHints = {
										enumMemberValues = { enabled = true },
										functionLikeReturnTypes = { enabled = true },
										parameterNames = { enabled = "literals" },
										parameterTypes = { enabled = true },
										propertyDeclarationTypes = { enabled = true },
										variableTypes = { enabled = false },
									},
								},
							},
						},
					},
				},
			})

			lspconfig.lua_ls.setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			lspconfig.rust_analyzer.setup({
				handlers = handlers,
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					["rust-analyzer"] = {
						procMacro = {
							enable = true,
						},
						diagnostics = {
							enable = true,
						},
					},
				},
			})

			-- lspconfig.typos_lsp.setup({
			-- 	-- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
			-- 	cmd_env = { RUST_LOG = "Info" },
			-- 	init_options = {
			-- 		-- Custom config. Used together with a config file found in the workspace or its parents,
			-- 		-- taking precedence for settings declared in both.
			-- 		-- Equivalent to the typos `--config` cli argument.
			-- 		-- config = "~/code/typos-lsp/crates/typos-lsp/tests/typos.toml",
			-- 		-- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
			-- 		-- Defaults to error.
			-- 		diagnosticSeverity = "Info",
			-- 	},
			-- })

			-- local signs = {
			-- 	{ name = "DiagnosticSignError", text = "" },
			-- 	{ name = "DiagnosticSignWarn", text = "" },
			-- 	{ name = "DiagnosticSignHint", text = "󰍉" },
			-- 	{ name = "DiagnosticSignInfo", text = " " },
			-- }
			--
			-- for _, sign in ipairs(signs) do
			-- 	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
			-- end
			--
			local config = {
				-- disable virtual text
				virtual_text = true,

				-- inlay_hints = {
				-- 	enabled = true,
				-- },
				-- show signs
				-- signs = {
				-- 	active = signs,
				-- },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.HINT] = "󰍉",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				update_in_insert = true,
				underline = true,
				severity_sort = true,
			}

			vim.diagnostic.config(config)

			-- Set global handlers
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = {}
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "H", function()
						vim.lsp.buf.hover({
							border = "rounded",
						})
					end, opts)
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
						-- vim.lsp.buf.format({ async = true })
						require("conform").format()
					end, opts)
				end,
			})

			-- LSP Progress notifications
			---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
			local progress = vim.defaulttable()
			vim.api.nvim_create_autocmd("LspProgress", {
				---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
					if not client or type(value) ~= "table" then
						return
					end
					local p = progress[client.id]

					for i = 1, #p + 1 do
						if i == #p + 1 or p[i].token == ev.data.params.token then
							p[i] = {
								token = ev.data.params.token,
								msg = ("[%3d%%] %s%s"):format(
									value.kind == "end" and 100 or value.percentage or 100,
									value.title or "",
									value.message and (" **%s**"):format(value.message) or ""
								),
								done = value.kind == "end",
							}
							break
						end
					end

					local msg = {} ---@type string[]
					progress[client.id] = vim.tbl_filter(function(v)
						return table.insert(msg, v.msg) or not v.done
					end, p)

					local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
					vim.notify(table.concat(msg, "\n"), "info", {
						id = "lsp_progress",
						title = client.name,
						opts = function(notif)
							notif.icon = #progress[client.id] == 0 and " "
								or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
						end,
					})
				end,
			})
		end,
	},
}
