-- Plugin: https://github.com/stevearc/conform.nvim
-- set up default formatters for Conform

local conform_status_ok, conform = pcall(require, "conform")
if not conform_status_ok then
	return
end

-- vim.keymap.set("", "<leader>F", function()
-- 	require("conform").format({ async = true })
-- end, { desc = "Format buffer" })
vim.keymap.set("", "<leader>F", function()
	conform.format({ async = true })
end, { desc = "Format buffer" })

-- get type hints
-- @module "conform"
-- @type conform.setupOpts
opts = {
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { "prettierd", "prettier", stop_after_first = true },
		jsonc = { "prettierd", "prettier", stop_after_first = true },
		plaintex = { "latexindent" },
		tex = { "latexindent" },
		markdown = { "markdownlint" },
		assembly = { "asmfmt" },
		asm = { "asmfmt" },
	},
	default_format_opts = { lsp_format = "fallback" },
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr"
	end,
}

conform.setup(opts)
