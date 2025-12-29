return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
		})
		-- REQUIRED

		-- Add file to harpoon list
		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end)

		-- Toggle harpoon quick menu
		vim.keymap.set("n", "<leader>he", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		-- Navigate to harpoon files (hjkl style)
		vim.keymap.set("n", "<leader>hh", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<leader>hj", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<leader>hk", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<leader>hl", function()
			harpoon:list():select(4)
		end)

		-- Navigate to harpoon files (number style)
		vim.keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)
	end,
}
