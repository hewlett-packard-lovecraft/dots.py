-- Plugin" https://github.com/rcarriga/nvim-dap-ui
-- set up neovim dap

local dap_status_ok, dap = pcall(require, "dap")

if not dap_status_ok then
	return
end

local dapview_status_ok, dv = pcall(require, "dap-view")
if not dapview_status_ok then
	return
end

-- configure dapview layout
dv.setup({
	winbar = {
		show = true,
		-- You can add a "console" section to merge the terminal with the other views
		sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
		-- Must be one of the sections declared above
		default_section = "watches",
	},
	windows = {
		height = 12,
		terminal = {
			-- 'left'|'right'|'above'|'below': Terminal position in layout
			position = "right",
			-- List of debug adapters for which the terminal should be ALWAYS hidden
			hide = {},
		},
	},
})

-- Automatically open help in vertical split
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "dap-view" }, -- dap-repl is set by `nvim-dap`
	command = "wincmd B",
})

-- dapview auto-open
dap.listeners.before.attach["dap-view-config"] = function()
	dv.open()
end
dap.listeners.before.launch["dap-view-config"] = function()
	dv.open()
end
--
-- dap.listeners.before.event_terminated["dap-view-config"] = function()
-- 	dv.close()
-- end
-- dap.listeners.before.event_exited["dap-view-config"] = function()
-- 	dv.close()
-- end
--
-- Map q to quit in nvim-dap-view filetypes:
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "dap-view", "dap-view-term", "dap-repl" }, -- dap-repl is set by `nvim-dap`
	callback = function(evt)
		vim.keymap.set("n", "q", "<C-w>q", { silent = true, buffer = evt.buf })
	end,
})

----------
-- keymaps
----------

-- vscode style binds:
-- F9: Toggle Breakpoint
-- F5: start/continue
-- Shift+F5: stop
-- F11 / shift+11 step into/out
-- F10: Step over
-- Ctrl+F10: Run to cursor
-- Ctrl+K Ctrl+I: show hover (also F1)
vim.keymap.set("n", "<F9>", function()
	require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint" })

vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end, { desc = "Continue (F5)" })

-- S+F5 = <F17>
vim.keymap.set("n", "<F17>", function()
	require("dap").terminate()
end, { desc = "Continue (S-F5)" })

vim.keymap.set("n", "<F11>", function()
	require("dap").step_into()
end, { desc = "Step into (F11)" })

-- S-F11 = <F23>
vim.keymap.set("n", "<F23>", function()
	require("dap").step_out()
end, { desc = "Step out (Shift+F11)" })

vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end, { desc = "Step over (F10)" })

-- C-F10 = <F34>
vim.keymap.set("n", "<F34>", function()
	require("dap").run_to_cursor()
end, { desc = "Run to cursor (Control + F10) " })

vim.keymap.set("n", "<C-K><C-I>", function()
	require("dap.ui.widgets").hover(nil, { border = "rounded" })
end, { desc = "Show hover (Ctrl+k, Ctrl+i), F1" })

vim.keymap.set("n", "<F3>", function()
	require("dap.ui.widgets").hover(nil, { border = "rounded" })
end, { desc = "Show hover <F3>" })
-- dapview
vim.keymap.set("n", "<leader>vv", function()
	require("dap-view").toggle()
end, { desc = "Toggle nvim-dap-view" })

vim.keymap.set("n", "<leader>vc", "<cmd>DapViewJump console<CR>", { desc = "Go to nvim-dap-view console" })
vim.keymap.set("n", "<leader>vw", "<cmd>DapViewJump watches<CR>", { desc = "Go to nvim-dap-view watch" })

vim.keymap.set("n", "<leader>ve", "<cmd>DapViewJump exceptions<CR>", { desc = "Go to nvim-dap-view exceptions" })

vim.keymap.set("n", "<leader>vb", "<cmd>DapViewJump breakpoints<CR>", { desc = "Go to nvim-dap-view breakpoints" })

vim.keymap.set("n", "<leader>dx", "<cmd>DapViewWatch<CR>", { desc = "Add expression with nvim-dap-view" })

vim.keymap.set("n", "<leader>vs", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes, { border = "rounded" })
end, { desc = "View scopes with nvim-dap-view" })

vim.keymap.set("n", "<leader>vh", function()
	require("dap.ui.widgets").hover(nil, { border = "rounded" })
end, { desc = "Hover mode with nvim-dap-view (F3)" })

-- dap

vim.keymap.set("n", "<leader>da", function()
	require("dap").continue()
end, { desc = "Continue (F5)" })
vim.keymap.set("n", "<leader>dd", function()
	require("dap").step_over()
end, { desc = "Step over (F10)" })
vim.keymap.set("n", "<leader>df", function()
	require("dap").step_into()
end, { desc = "Step into (F11)" })
vim.keymap.set("n", "<leader>dg", function()
	require("dap").step_out()
end, { desc = "Step out (Shift+F11)" })
vim.keymap.set("n", "<leader>dr", function()
	require("dap").restart()
end, { desc = "Pause" })
vim.keymap.set("n", "<leader>ds", function()
	require("dap").pause()
end, { desc = "Pause" })
vim.keymap.set("n", "<leader>dv", function()
	require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint (F9)" })
vim.keymap.set("n", "<leader>dt", function()
	require("dap").terminate()
end, { desc = "Stop (Shift+F5)" })

vim.keymap.set("n", "<leader>dC", function()
	require("dap").run_to_cursor()
end, { desc = "Run to cursor (Control + F10) " })
vim.keymap.set("n", "<leader>dl", function()
	require("dap.ext.vscode").load_launchjs()
end, { desc = "Load ./vscode/launch.js" })
