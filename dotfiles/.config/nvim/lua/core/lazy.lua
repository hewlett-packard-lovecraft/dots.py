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
			opts = {},
		},

		-- Telescope
		{
			"nvim-telescope/telescope.nvim",
			branch = "0.1.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
				"nvim-telescope/telescope-ui-select.nvim",
				"nvim-telescope/telescope-dap.nvim",
			},
		},
		{
			"stevearc/oil.nvim",
			opts = {
				default_file_explorer = true,
			},
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
			opts = {
				options = {
					theme = "codedark",
					disabled_filetypes = {
						winbar = {
							"dap-view",
							"dap-repl",
							"dap-view-term",
						},
					},
				},
			},
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
			opts = {},
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
			"dstein64/vim-startuptime",
			lazy = false,
			cmd = "StartupTime",
		},
		-- various utils
		{
			"numToStr/Comment.nvim",
			lazy = false,
			opts = {},
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
		"michaeljsmith/vim-indent-object",
		"wellle/targets.vim",
		-- > various utils
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},
		{ "stevearc/dressing.nvim", event = "VeryLazy" },
		{ "folke/neoconf.nvim", cmd = "Neoconf" },

		-- LSP server-specific plugins
		{
			"folke/trouble.nvim",
			opts = {}, -- for default options, refer to the configuration section for custom setup.
			cmd = "Trouble",
			keys = {
				{
					"<leader>xx",
					"<cmd>Trouble diagnostics toggle<cr>",
					desc = "Diagnostics (Trouble)",
				},
				{
					"<leader>xX",
					"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
					desc = "Buffer Diagnostics (Trouble)",
				},
				{
					"<leader>cs",
					"<cmd>Trouble symbols toggle focus=false<cr>",
					desc = "Symbols (Trouble)",
				},
				{
					"<leader>cl",
					"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
					desc = "LSP Definitions / references / ... (Trouble)",
				},
				{
					"<leader>xL",
					"<cmd>Trouble loclist toggle<cr>",
					desc = "Location List (Trouble)",
				},
				{
					"<leader>xQ",
					"<cmd>Trouble qflist toggle<cr>",
					desc = "Quickfix List (Trouble)",
				},
			},
		},

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
			-- keys = {
			-- 	"<leader>F",
			-- 	function()
			-- 		require("conform").format({ async = true })
			-- 	end,
			-- 	mode = "",
			-- 	desc = "Format buffer",
			-- },
			opts = {},
		},
		-- Configure DAP
		-- {
		-- 	"rcarriga/nvim-dap-ui",
		-- 	dependencies = {
		-- 		"jay-babu/mason-nvim-dap.nvim",
		-- 		"mfussenegger/nvim-dap",
		-- 		"theHamsta/nvim-dap-virtual-text",
		-- 		"nvim-neotest/nvim-nio",
		-- 	},
		-- },

		{
			"theHamsta/nvim-dap-virtual-text",
			config = true,
			dependencies = { "nvim-treesitter/nvim-treesitter", "mfussenegger/nvim-dap" },
		},
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = {
				"williamboman/mason.nvim",
				"mfussenegger/nvim-dap",
			},
		},
		{
			"mfussenegger/nvim-dap",
			dependencies = {
				{ "igorlfs/nvim-dap-view", opts = {} },
			},
		},

		-- tasks.json
		{
			"stevearc/overseer.nvim",
			opts = {},
		},

		-- Configure Latex
		"lervag/vimtex",
		{
			"iurimateus/luasnip-latex-snippets.nvim",
			-- vimtex isn't required if using treesitter
			requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
			opts = {},
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
