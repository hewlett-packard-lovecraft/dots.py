-- Plugin" https://github.com/rcarriga/nvim-dap-ui
-- set up neovim dap

local dap_status_ok, dap = pcall(require, "dap")

if not dap_status_ok then
	return
end

local dapui_status_ok, dapui = pcall(require, "dapui")
if not dapui_status_ok then
	return
end

dapui.setup()

-- autolaunch/close dap when start/close new session
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- define keymaps

-- dapui
vim.keymap.set("n", "<leader>du", function()
	dapui.toggle()
end, { desc = "Toggle debugger" })

-- dap
vim.keymap.set("n", "<leader>db", function()
	dap.toggle_breakpoint()
end, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>do", function()
	dap.open()
end, { desc = "Open debugger" })
vim.keymap.set("n", "<leader>dc", function()
	dap.continue()
end, { desc = "Continue" })
vim.keymap.set("n", "<leader>dC", function()
	dap.run_to_cursor()
end, { desc = "Run to cursor" })
vim.keymap.set("n", "<leader>dT", function()
	dap.terminate()
end, { desc = "Terminate" })
