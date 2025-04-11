-- Plugin" https://github.com/rcarriga/nvim-dap-ui
-- set up neovim dap

local dap_status_ok, dap = pcall(require, "dap")

if not dap_status_ok then
	return
end

local dapview_status_ok, dapview = pcall(require, "dap-view")
if not dapview_status_ok then
	return
end

-- dapview auto-open
local dap, dv = require("dap"), require("dap-view")
dap.listeners.before.attach["dap-view-config"] = function()
	dv.open()
end
dap.listeners.before.launch["dap-view-config"] = function()
	dv.open()
end
dap.listeners.before.event_terminated["dap-view-config"] = function()
	dv.close()
end
dap.listeners.before.event_exited["dap-view-config"] = function()
	dv.close()
end

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

-- dapview
vim.keymap.set("n", "<leader>vv", function()
	require("dap-view").toggle()
end, { desc = "Toggle nvim-dap-view" })

vim.keymap.set("n", "<leader>vw", function()
	require("dap-view").jump("[watch]") -- Can be used to jump to a specific view, from any window
end, { desc = "Go to nvim-dap-view watch" })

vim.keymap.set("n", "<leader>ve", function()
	require("dap-view").jump("[exeptions]") -- Can be used to jump to a specific view, from any window
end, { desc = "Go to nvim-dap-view exeptions" })

vim.keymap.set("n", "<leader>vb", function()
	require("dap-view").jump("[breakpoints]") -- Can be used to jump to a specific view, from any window
end, { desc = "Go to nvim-dap-view breakpoints" })

vim.keymap.set("n", "<leader>dx", function()
	require("dap-view").add_expr()
end, { desc = "Add expression with nvim-dap-view" })

vim.keymap.set("n", "<leader>dS", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes, { border = "rounded" })
end, { desc = "View scopes with nvim-dap-view" })

vim.keymap.set("n", "<leader>dh", function()
	require("dap.ui.widgets").hover(nil, { border = "rounded" })
end, { desc = "Hover mode with nvim-dap-view" })

-- dap

vim.keymap.set("n", "<leader>da", function()
	require("dap").continue()
end, { desc = "Continue" })
vim.keymap.set("n", "<leader>de", function()
	require("dap").run_to_cursor()
end, { desc = "Run to cursor" })
vim.keymap.set("n", "<leader>dd", function()
	require("dap").step_over()
end, { desc = "Step over" })
vim.keymap.set("n", "<leader>df", function()
	require("dap").step_into()
end, { desc = "Step into" })
vim.keymap.set("n", "<leader>dg", function()
	require("dap").step_out()
end, { desc = "Step out" })
vim.keymap.set("n", "<leader>dr", function()
	require("dap").restart()
end, { desc = "Pause" })
vim.keymap.set("n", "<leader>ds", function()
	require("dap").pause()
end, { desc = "Pause" })
vim.keymap.set("n", "<leader>dv", function()
	require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dt", function()
	require("dap").terminate()
end, { desc = "Continue" })

vim.keymap.set("n", "<leader>dC", function()
	require("dap").run_to_cursor()
end, { desc = "Run to cursor" })
vim.keymap.set("n", "<leader>dl", function()
	require("dap.ext.vscode").load_launchjs()
end, { desc = "Load ./vscode/launch.js" })
