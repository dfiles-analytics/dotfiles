require("config.lazy")
require("config.options")

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"sql","yaml","toml","xml","html"},
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"python","lua","ruby"},
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.expandtab = false
	end,
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
	pattern = {".gitconfig", "*.gitconfig"},
	callback = function()
		vim.bo.filetype = "dosini"
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = false
	end,
})
