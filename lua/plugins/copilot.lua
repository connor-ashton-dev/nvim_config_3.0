return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "BufReadPost",
	dependencies = {
		"copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
	},
	opts = {
		suggestion = {
			-- enabled = not vim.g.ai_cmp,
			enabled = false,
			auto_trigger = false,
			hide_during_completion = vim.g.ai_cmp,
			keymap = {
				accept = "<C-a>",
				next = "<M-]>",
				prev = "<M-[>",
			},
		},
		nes = {
			enabled = true,
			keymap = {
				accept_and_goto = "<tab>",
				accept = false,
				dismiss = "<esc>",
			},
		},
		panel = { enabled = false },
		filetypes = {
			markdown = true,
			help = true,
		},
	},
}
