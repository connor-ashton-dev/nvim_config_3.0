return {
	"pmizio/typescript-tools.nvim",
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	config = function()
		require("typescript-tools").setup({
			publish_diagnostic_on = "change",
		})
	end,
}
