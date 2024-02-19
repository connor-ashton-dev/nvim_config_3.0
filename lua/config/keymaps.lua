local opts = { noremap = true, silent = true }
local noisy_opts = { noremap = true, silent = false }

local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--MOVES BLOCKS OF TEXT
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

--KEEPS CURSOR IN THE MIDDLE OF SCREEN WHEN...
--jumping around with c and d
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-e>", "10zl", opts)
keymap("n", "<C-w>", "10zh", opts)

--remove highlight with ESC
keymap("n", "<ESC>", ":nohl<CR>", opts)

--FILE STUFF
--save and format
keymap("n", "<leader>w", ":w<CR>", opts)
--mega quit
keymap("n", "<leader>K", ":xa!<CR>", opts)
--kinda quit
keymap("n", "<leader>q", ":q!<CR>", opts)
--undotree
keymap("n", "<leader>u", ":UndotreeToggle<CR>", opts)

--keeps current item in buffer when you past over something
keymap("x", "<leader>p", [["_dP]], opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

--explorer
keymap("n", "<leader>e", ":Neotree toggle<CR>", opts)

-- telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fs", ":Telescope spell_suggest<CR>", opts)
keymap("n", "<leader>fv", ":Telescope treesitter<CR>", opts)
keymap("n", "<leader>fr", ":Telescope lsp_references<CR>", opts)
keymap("n", "<leader>vk", ":Telescope keymaps<CR>", opts)

-- copilot
keymap("n", "<leader>gcs", ":Copilot status<CR>", opts)
keymap("n", "<leader>gce", ":Copilot enable<CR>", opts)
keymap("n", "<leader>gcd", ":Copilot disable<CR>", opts)
keymap("n", "<leader>gcp", ":Copilot panel<CR>", opts)

-- yabs
keymap("n", "<leader>r", ":YabsDefaultTask<CR>", opts)
keymap(
	"n",
	"<leader>fa",
	"<cmd>lua local task = vim.fn.input('Enter task name: '); vim.cmd(':YabsTask ' .. task)<cr>",
	opts
)

-- editor stuff
keymap("n", "<leader>vr", ":set relativenumber!<CR>", opts)

-- lsp stuff
local function toggle_virtual_text()
	local current_config = vim.diagnostic.config()
	current_config.virtual_text = not current_config.virtual_text
	vim.diagnostic.config(current_config)
end

keymap("n", "<leader>lt", function()
	toggle_virtual_text()
end, { noremap = true })
keymap("n", "<leader>lr", ":LspRestart<CR>:echo 'LSP Restarted.'<CR>", opts)
keymap("n", "<leader>t", ":TroubleToggle<CR>", opts)
