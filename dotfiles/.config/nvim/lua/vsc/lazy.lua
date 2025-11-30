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
		-- {
		-- 	"vscode-neovim/vscode-multi-cursor.nvim",
		-- 	event = "VeryLazy",
		-- 	cond = not not vim.g.vscode,
		-- 	opts = {},
		-- },
		{
			"chrisgrieser/nvim-various-textobjs",
			event = "VeryLazy",
			opts = {
				keymaps = {
					useDefaults = true,
				},
			},
		},
		{
			"folke/flash.nvim",
			event = "VeryLazy",
			---@type Flash.Config
			opts = {},
      -- stylua: ignore
      keys = {
        { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
        { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
      },
		},
		{
			"chrisgrieser/nvim-spider",
			opts = {
				skipInsignificantPunctuation = false,
				consistentOperatorPending = false, -- see the README for details
				subwordMovement = true,
				customPatterns = {},
				-- customPatterns = { patterns = { "{", "}", "(", ")" }, overrideDefault = false }, -- see the README for details
			},
			keys = {
				{
					"w",
					"<cmd>lua require('spider').motion('w')<CR>",
					mode = { "n", "o", "x" },
				},
				{
					"e",
					"<cmd>lua require('spider').motion('e')<CR>",
					mode = { "n", "o", "x" },
				},
				{
					"b",
					"<cmd>lua require('spider').motion('b')<CR>",
					mode = { "n", "o", "x" },
				},
				-- {
				-- 	"W",
				-- 	"<cmd>lua require('spider').motion('W', { skipInsignificantPunctuation = true }) <CR>",
				-- 	mode = { "n", "o", "x" },
				-- },
				-- {
				-- 	"E",
				-- 	"<cmd>lua require('spider').motion('E', { skipInsignificantPunctuation = true }) <CR>",
				-- 	mode = { "n", "o", "x" },
				-- },
				-- {
				-- 	"B",
				-- 	"<cmd>lua require('spider').motion('B'), { skipInsignificantPunctuation = true }) <CR>",
				-- 	mode = { "n", "o", "x" },
				-- },
				{
					"<C-f>",
					"<Esc>l<cmd>lua require('spider').motion('w')<CR>i",
					mode = { "i" },
				},
				{
					"<C-b>",
					"<Esc><cmd>lua require('spider').motion('b')<CR>i",
					mode = { "i" },
				},
			},
		},
		"numToStr/Comment.nvim",
		-- "michaeljsmith/vim-indent-object",
		-- "wellle/targets.vim",
		"windwp/nvim-autopairs",
	},
})
