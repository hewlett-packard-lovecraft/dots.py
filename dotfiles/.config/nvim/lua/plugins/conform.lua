-- Plugin: https://github.com/stevearc/conform.nvim
-- set up default formatters for Conform

local conform_status_ok, conform = pcall(require, "conform")
if not conform_status_ok then
	return
end

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "eslint_d", "prettierd", "prettier" } },
		java = { "uncrustify" }, -- not really neccessary. this will fall back to nvim-jdtls if uncrustify not installed manually
		plaintex = { "latexindent" },
		tex = { "latexindent" },
		markdown = { "markdownlint" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
})
