-- Neovim init file

if vim.g.vscode then
    -- VSCode extension
		require("vscode/lazy")
		require("vscode/options")
else
    -- ordinary Neovim
	require("core/lazy")
	require("core/autocmd")
	require("core/keymaps")
	require("core/colours")
	require("core/options")
	require("lsp-dap/mason")
	-- require("lsp-dap/nvim-jdtls")
	require("plugins/conform")
	require("lsp-dap/neodev")
	require("lsp-dap/lspconfig")
	require("lsp-dap/dapconfig")
	require("plugins/vimtex")
	require("plugins/workspaces")
	-- require("plugins/nvim-tree")
	require("plugins/telescope")
	require("plugins/indent-blankline")
	require("plugins/nvim-cmp")
	require("plugins/nvim-treesitter")
end
