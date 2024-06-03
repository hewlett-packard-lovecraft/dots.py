-- Plugin: https://github.com/folke/neodev.nvim
-- Configure Neodev to load before nvim-lspconfig

-- local neodev_status_ok, neodev = pcall(require, 'neodev')
-- if not neodev_status_ok then
--   return
-- end

local neodev = require("neodev")

neodev.setup({
	-- add any options here, or leave empty to use the default settings
	library = { plugins = { "nvim-dap-ui" }, types = true },
})
