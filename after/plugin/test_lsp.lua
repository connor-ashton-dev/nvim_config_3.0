-- local client = vim.lsp.start_client({
-- 	name = "connorlsp",
-- 	cmd = { "/Users/connorashton/Desktop/Personal/Dev/Go/projects/lsp/go-lsp" },
-- })
--
-- if not client then
-- 	vim.notify("hey, you need to start your custom lsp server!")
-- 	return
-- end
--
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "markdown",
-- 	callback = function()
-- 		vim.lsp.buf_attach_client(0, client)
-- 	end,
-- })
