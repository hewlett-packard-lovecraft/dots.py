-- neovim-vscode init file
-- bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

-- Start setup
lazy.setup({
	spec = {
		"easymotion/vim-easymotion",
		"numToStr/Comment.nvim",
		"michaeljsmith/vim-indent-object",
		"justinmk/vim-sneak",
		"bkad/CamelCaseMotion",
		"vim-scripts/ReplaceWithRegister",
		"wellle/targets.vim",
		"windwp/nvim-autopairs",
	},
})
