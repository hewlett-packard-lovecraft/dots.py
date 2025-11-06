-- Plugin: https://github.com/williamboman/mason.nvim
-- automatically install language servers
-- needs to be loaded before lspconfig

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
	return
end

local nvim_lint_status_ok, nvim_lint = pcall(require, "lint")
if not nvim_lint_status_ok then
	return
end

local mason_tool_installer_ok, mason_tool_installer = pcall(require, "mason-tool-installer")
if not mason_tool_installer_ok then
	return
end

local mason_nvim_dap_ok, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not mason_nvim_dap_ok then
	return
end

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

mason_lspconfig.setup({
	ensure_installed = {
		"lua_ls",
		"ruff",
		"ltex",
		"texlab",
		"jdtls",
	},
	automatic_installation = {
		"lua_ls",
		"ruff",
		"ltex-ls-plus",
		"texlab",
		"jdtls",
		"bash-language-server",
	},
})

mason_tool_installer.setup({
	ensure_installed = {
		"eslint-lsp",
		"stylua",
		"black",
		"isort",
		"prettierd",
		"prettier",
		"markdownlint",
		"bash-language-server",
		"shellcheck",
		"shfmt",
	},
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		nvim_lint.try_lint()
	end,
})

mason_nvim_dap.setup({
	ensure_installed = { "python", "cppdbg", "js", "bash" },
	handlers = {},
})
