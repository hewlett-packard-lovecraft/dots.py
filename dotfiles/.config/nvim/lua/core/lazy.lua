-- lazy.nvim config file

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
		-- Colorscheme:
		{
			"Mofiqul/vscode.nvim",
			lazy = false, -- make sure we load this during startup if it is your main colorscheme
			priority = 1000,
		},
		-- Icons
		{ "kyazdani42/nvim-web-devicons", lazy = true },

		-- Git labels
		{
			"lewis6991/gitsigns.nvim",
			lazy = true,
			dependencies = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
			},
			config = function()
				require("gitsigns").setup({})
			end,
		},

		-- Telescope
		{
			"nvim-telescope/telescope.nvim",
			branch = "0.1.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
				"nvim-telescope/telescope-ui-select.nvim",
			},
		},
		{
			"stevearc/oil.nvim",
			config = function()
				require("oil").setup({ default_file_explorer = true })
			end,
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},
		{
			"natecraddock/workspaces.nvim",
			dependencies = {
				"natecraddock/sessions.nvim",
				"nvim-telescope/telescope.nvim",
			},
		},

		-- Statusline
		{
			"nvim-lualine/lualine.nvim",
			dependencies = {
				"kyazdani42/nvim-web-devicons",
				"lewis6991/gitsigns.nvim",
			},
			config = function()
				require("lualine").setup()
			end,
		},

		-- Treesitter
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

		-- Indent line
		{ "lukas-reineke/indent-blankline.nvim" },

		-- Tag viewer
		{ "preservim/tagbar" },

		-- Autopair
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		},

		-- LSP
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
			},
		},

		-- Autocomplete
		{
			"hrsh7th/nvim-cmp",
			-- load cmp on InsertEnter
			event = "InsertEnter",
			-- these dependencies will only be loaded when cmp loads
			-- dependencies are always lazy-loaded unless specified otherwise
			dependencies = {
				"L3MON4D3/LuaSnip",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-buffer",
				"saadparwaiz1/cmp_luasnip",
			},
		},

		{
			"nvim-neorg/neorg",
			ft = "norg",
			config = true, -- run require("neorg").setup()
		},
		{
			"dstein64/vim-startuptime",
			lazy = false,
			cmd = "StartupTime",
		},
		{
			"numToStr/Comment.nvim",
			lazy = false,
			config = function()
				require("Comment").setup()
			end,
		},
		{
			"folke/which-key.nvim",
			-- lazy = true,
			config = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
				require("which-key").setup()
			end,
		},
		{ "stevearc/dressing.nvim", event = "VeryLazy" },
		{ "folke/neoconf.nvim", cmd = "Neoconf" },

		-- LSP server-specific plugins
		"folke/neodev.nvim",
		{
			"mfussenegger/nvim-jdtls",
			dependencies = {
				"williamboman/mason.nvim",
			},
		},
		-- formatters and linters
		"rshkarin/mason-nvim-lint",
		"mfussenegger/nvim-lint",
		{
			"stevearc/conform.nvim",
			opts = {},
		},
		-- Configure DAP
		{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		},

		-- Configure Latex
		"lervag/vimtex",
		{
			"iurimateus/luasnip-latex-snippets.nvim",
			-- vimtex isn't required if using treesitter
			requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
			config = function()
				require("luasnip-latex-snippets").setup()
			end,
		},
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_snipmate").lazy_load()
				require("luasnip").filetype_extend("python", { "django" })
			end,
		},
		"equalsraf/neovim-gui-shim",
		-- language aware tabs
		"gpanders/editorconfig.nvim",
		{},
	},
})
