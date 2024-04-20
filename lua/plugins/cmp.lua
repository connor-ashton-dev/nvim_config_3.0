return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "LspAttach" },
	-- fix_pairs = true,
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	build = "make install_jsregexp",
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			-- sorting = {
			-- 	priority_weight = 2,
			-- 	comparators = {
			-- 		require("copilot_cmp.comparators").prioritize,
			--
			-- 		-- Below is the default comparitor list and order for nvim-cmp
			-- 		cmp.config.compare.offset,
			-- 		-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
			-- 		cmp.config.compare.exact,
			-- 		cmp.config.compare.score,
			-- 		cmp.config.compare.recently_used,
			-- 		cmp.config.compare.locality,
			-- 		cmp.config.compare.kind,
			-- 		cmp.config.compare.sort_text,
			-- 		cmp.config.compare.length,
			-- 		cmp.config.compare.order,
			-- 	},
			-- },
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				-- Add tab support
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				-- ["<Tab>"] = cmp.mapping.select_next_item(),

				["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				-- { name = "copilot", group_index = 2 },
				{ name = "nvim_lsp", group_index = 2 },
				{ name = "nvim_lsp_signature_help", group_index = 2 },
				{ name = "luasnip", group_index = 2 }, -- snippets
				{ name = "buffer", group_index = 2 }, -- text within current buffer
				{ name = "path", group_index = 2 }, -- file system paths
			}),
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol",
					maxwidth = 50,
					ellipsis_char = "...",
					-- symbol_map = { Copilot = "" },
				}),
			},
			window = {
				completion = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					-- winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
				},
				documentation = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					-- winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
				},
			},
		})
	end,
}
