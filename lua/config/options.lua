vim.cmd([[colorscheme rose-pine]])

vim.opt.guicursor = ""
vim.opt.shell = "/bin/sh"

-- make cursor not blink
-- vim.opt.guicursor = "a:Cursor/Cursor"

vim.opt.relativenumber = true
vim.opt.nu = true

vim.g.editorconfig = true
--sets clipboard to system
vim.api.nvim_set_option("clipboard", "unnamed")

vim.opt.ignorecase = false

vim.opt.expandtab = false
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

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
	callback = function()
		vim.fn.timer_start(8000, function()
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
