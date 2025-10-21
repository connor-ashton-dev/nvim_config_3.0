local vscode = require("vscode")
---------------------------------------KEYMAPS---------------------------------------
local opts = { noremap = true, silent = true }
-- local noisy_opts = { noremap = true, silent = false }

local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--MOVES BLOCKS OF TEXT
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

--remove highlight with ESC
keymap("n", "<ESC>", ":nohl<CR>", opts)

-- map : to bring up VSCode command palette
keymap("n", ":", function()
	vscode.action("workbench.action.showCommands")
end, opts)

-- map leader w to save
keymap("n", "<leader>w", ":w<cr>")
-- move hover to H
keymap("n", "H", function()
	vscode.action("editor.action.showHover")
end)
-- another change

keymap("n", "<leader><leader>", function()
	vscode.action("workbench.action.quickOpen")
end)

keymap("n", "<leader>e", function()
	vscode.action("workbench.view.explorer")
end)
keymap("n", "<leader>w", function()
	vscode.action("workbench.action.files.save")
end)
keymap("n", "<leader>q", function()
	vscode.action("workbench.action.closeActiveEditor")
end)
keymap("n", "<leader>rn", function()
	vscode.action("editor.action.rename")
end)
keymap("n", "<leader>v", function()
	vscode.action("workbench.action.gotoSymbol")
end)
keymap("n", "<leader>fd", function()
	vscode.action("editor.action.formatDocument")
end)
keymap("n", "<leader>ca", function()
	vscode.action("editor.action.codeAction")
end)
keymap("n", "<leader>t", function()
	vscode.action("workbench.actions.view.problems")
end)
keymap("n", "<leader>gg", function()
	vscode.action("workbench.view.scm")
end)

-- this is the most recent change
keymap("n", "fr", function()
	vscode.action("workbench.action.findInFiles", { args = { query = vim.fn.expand("<cword>") } })
end, opts)

keymap("n", "gn", function()
	vscode.action("editor.action.marker.next")
end)
keymap("n", "gp", function()
	vscode.action("editor.action.marker.prev")
end)
keymap("n", "gl", function()
	vscode.action("editor.action.marker.this")
end)

keymap("n", "<leader>ha", function()
	vscode.action("vscode-harpoon.addEditor")
end)
keymap("n", "<leader>he", function()
	vscode.action("vscode-harpoon.editEditors")
end)
keymap("n", "<leader>1", function()
	vscode.action("vscode-harpoon.gotoEditor1")
end)
keymap("n", "<leader>2", function()
	vscode.action("vscode-harpoon.gotoEditor2")
end)
keymap("n", "<leader>3", function()
	vscode.action("vscode-harpoon.gotoEditor3")
end)
keymap("n", "<leader>4", function()
	vscode.action("vscode-harpoon.gotoEditor4")
end)
keymap("n", "<leader>5", function()
	vscode.action("vscode-harpoon.gotoEditor5")
end)

---------------------------------------SETTINGS---------------------------------------
vim.opt.guicursor = ""
vim.opt.shell = "/opt/homebrew/bin/fish"
vim.opt.relativenumber = true
vim.opt.nu = true
vim.g.editorconfig = true
vim.opt.clipboard = "unnamed"

vim.opt.ignorecase = false

vim.opt.ruler = false

vim.opt.autoindent = true

vim.opt.splitbelow = false
vim.opt.splitright = true

vim.opt.fillchars:append({ eob = " " })

vim.opt.smartindent = false
vim.opt.cindent = true
vim.opt.showmode = false

local format_group = vim.api.nvim_create_augroup("format_options", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	group = format_group,
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
})

vim.opt.wrap = false
vim.opt.linebreak = false
vim.opt.mouse = "a"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 750

vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }

-- Show a lil thing when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight neovim when yanking",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			higroup = "Visual",
			timeout = 100,
		})
	end,
})

---------------------------------------EXTENSIONS---------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"vscode-neovim/vscode-multi-cursor.nvim",
		event = "VeryLazy",
		cond = not not vim.g.vscode,
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				char = {
					enabled = false,
					jump_labels = false,
				},
			},
		},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
	},
})
