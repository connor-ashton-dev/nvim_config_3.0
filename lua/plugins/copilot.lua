local enable_ai = function()
	-- local current_dir = vim.fn.getcwd()
	-- local home_dir = os.getenv("HOME") or os.getenv("USERPROFILE")
	-- local code_path = home_dir .. "/code"
	--
	-- -- if git repo is filed under ~/code/_private, do not allow AI
	-- local private_path = code_path .. "/_private"
	-- local is_code_private = string.find(current_dir, private_path) == 1
	--
	-- if is_code_private then
	-- 	return false
	-- else
	-- 	return true
	-- end
	return false
end

return {

	-- custom config which piggybacks on the copilot extras in lazy.lua.
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = true,
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<C-y>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
			})

			-- hide copilot suggestions when cmp menu is open
			-- to prevent odd behavior/garbled up suggestions
			local cmp_status_ok, cmp = pcall(require, "cmp")
			if cmp_status_ok then
				cmp.event:on("menu_opened", function()
					vim.b.copilot_suggestion_hidden = true
				end)

				cmp.event:on("menu_closed", function()
					vim.b.copilot_suggestion_hidden = false
				end)
			end

			-- disable copilot based off some condition
			if not enable_ai() then
				vim.cmd("Copilot disable")
			end
		end,
	},

	-- https://github.com/jackMort/ChatGPT.nvim
	-- {
	-- 	"jackMort/ChatGPT.nvim",
	-- 	dependencies = {
	-- 		{ "MunifTanjim/nui.nvim" },
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 		{ "nvim-telescope/telescope.nvim" },
	-- 	},
	-- 	-- event = "VeryLazy",
	-- 	config = function()
	-- 		require("chatgpt").setup({
	-- 			actions_paths = { "~/code/dotfiles/nvim-lazyvim/chatgpt-actions.json" },
	-- 			openai_params = {
	-- 				model = "gpt-4",
	-- 			},
	-- 			openai_edit_params = {
	-- 				model = "gpt-3.5-turbo",
	-- 				temperature = 0,
	-- 				top_p = 1,
	-- 				n = 1,
	-- 			},
	-- 		})
	-- 	end,
	-- },

	-- https://github.com/David-Kunz/gen.nvim
	-- {
	-- 	"David-Kunz/gen.nvim",
	-- 	config = function()
	-- 		require("gen").model = "codellama"
	-- 	end,
	-- },
}
