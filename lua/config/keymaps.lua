local opts = { noremap = true, silent = true }
-- local noisy_opts = { noremap = true, silent = false }

local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move text down" })
--MOVES BLOCKS OF TEXT
keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move text up" })

--KEEPS CURSOR IN THE MIDDLE OF SCREEN WHEN...
--jumping around with c and d
keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Scroll down (centered)" })
keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Scroll up (centered)" })
-- keymap("n", "<C-e>", "10zl", opts)
-- keymap("n", "<C-w>", "10zh", opts)

--remove highlight with ESC and exit snippets
keymap("n", "<ESC>", function()
	-- Clear search highlights
	vim.cmd("nohl")
	-- Exit snippet session if active
	if vim.snippet then
		vim.snippet.stop()
	end
end, { noremap = true, silent = true, desc = "Clear highlights" })

--FILE STUFF
--save and format
keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Save file" })
-- mega save
keymap("n", "<leader>W", ":wa!<CR>", { noremap = true, silent = true, desc = "Save all files" })
--mega quit
keymap("n", "<leader>K", ":xa!<CR>", { noremap = true, silent = true, desc = "Quit all (save)" })
--kinda quit
keymap("n", "<leader>q", ":q!<CR>", { noremap = true, silent = true, desc = "Quit (no save)" })
--undotree
keymap("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle undotree" })

--keeps current item in buffer when you past over something
keymap("x", "<leader>p", [["_dP]], { noremap = true, silent = true, desc = "Paste without yank" })

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", { noremap = true, silent = true, desc = "Resize window up" })
keymap("n", "<C-Down>", ":resize -2<CR>", { noremap = true, silent = true, desc = "Resize window down" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true, desc = "Resize window left" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true, desc = "Resize window right" })

--explorer (yazi.nvim handles <leader>e keybind)
-- keymap("n", "<leader>e", ":Neotree toggle right reveal <CR>", opts)
-- keymap("n", "<leader>e", ":lua Snacks.explorer()<CR>", opts)
-- keymap("n", "<leader>e", ":Oil<CR>", opts)

-- find and replace
keymap("n", "<leader>rt", ":GrugFar<CR>", { noremap = true, silent = true, desc = "Find and replace (GrugFar)" })

-- quickfix
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "<CR>", "<CR>", { buffer = true, noremap = true, silent = true, desc = "Jump to entry" })
	end,
})
keymap("n", "]q", ":cnext<CR>", { noremap = true, silent = true, desc = "Next quickfix" })
keymap("n", "[q", ":cprev<CR>", { noremap = true, silent = true, desc = "Previous quickfix" })
keymap("n", "]c", ":cclose<CR>", { noremap = true, silent = true, desc = "Close quickfix" })
keymap("n", "]o", ":copen<CR>", { noremap = true, silent = true, desc = "Open quickfix" })

-- editor stuff
keymap("n", "<leader>vr", ":set relativenumber!<CR>", { noremap = true, silent = true, desc = "Toggle relative numbers" })
keymap("n", "<leader>zm", ":ZenMode<CR>", { noremap = true, silent = true, desc = "Toggle Zen Mode" })
keymap("n", "<leader>ct", ":tabc<CR>", { noremap = true, silent = true, desc = "Close tab" })

-- lsp stuff
local function toggle_virtual_text()
	local current_config = vim.diagnostic.config()
	current_config.virtual_text = not current_config.virtual_text
	vim.diagnostic.config(current_config)
end

keymap("n", "<leader>lt", function()
	toggle_virtual_text()
end, { noremap = true, desc = "Toggle virtual text" })

keymap("n", "<leader>lr", ":LspRestart<CR>:echo 'LSP Restarted.'<CR>", { noremap = true, silent = true, desc = "Restart LSP" })

-- lazygit

keymap("n", "<leader>gf", ":tab Git<CR>", { noremap = true, silent = true, desc = "Git status (Fugitive)" })
keymap("n", "<leader>gg", ":lua Snacks.lazygit()<CR>", { noremap = true, silent = true, desc = "Lazygit" })
keymap("n", "<leader>gd", ":DiffviewOpen<CR>", { noremap = true, silent = true, desc = "Diff view" })
