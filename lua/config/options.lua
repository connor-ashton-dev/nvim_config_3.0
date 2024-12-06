vim.cmd([[colorscheme rose-pine]])

vim.opt.guicursor = ""
vim.opt.shell = "/opt/homebrew/bin/fish"

vim.opt.relativenumber = true
vim.opt.nu = true

vim.g.editorconfig = true
--sets clipboard to system
vim.opt.clipboard = "unnamed"

vim.opt.ignorecase = false

vim.opt.ruler = false

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

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

local cmdline_group = vim.api.nvim_create_augroup("cmdline_cleanup", { clear = true })
vim.api.nvim_create_autocmd("CmdlineLeave", {
	group = cmdline_group,
	callback = function()
		vim.fn.timer_start(4000, function()
			vim.cmd([[ echon ' ' ]])
		end)
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
