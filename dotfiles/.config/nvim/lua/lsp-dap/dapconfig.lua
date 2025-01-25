-- Plugin: https://github.com/rcarriga/nvim-dap-ui
-- set up neovim dap

local dapui_status_ok, dapui = pcall(require, "dapui")
if not dapui_status_ok then
	return
end

dapui.setup()
