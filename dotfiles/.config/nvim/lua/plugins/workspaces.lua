local workspaces_status_ok, workspaces = pcall(require, "workspaces")
if not workspaces_status_ok then
	return
end

local session_status_ok, sessions = pcall(require, "sessions")
if not session_status_ok then
	return
end

sessions.setup({
	events = { "WinEnter" },
	session_filepath = vim.fn.stdpath("data") .. "/sessions",
	absolute = true,
})

workspaces.setup({
	path = vim.fn.stdpath("data") .. "/workspaces",
	hooks = {
		open = { "NvimTreeOpen", "Telescope find_files", "SessionsLoad" },
	},
})
