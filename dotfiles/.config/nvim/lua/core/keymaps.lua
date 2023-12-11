-- nmap's and map's

function map(mode, shortcut, command)
	-- vim.api.nvim_set_keymap(mode, keys, mapping, options)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
	map("n", shortcut, command)
end

function imap(shortcut, command)
	map("i", shortcut, command)
end

nmap("<A-Up>", ":wincmd k<CR>") -- alternate split keys for insert m(alt + arrow keys)
nmap("<A-Down>", ":wincmd j<CR>")
nmap("<A-Left>", ":wincmd h<CR>")
nmap("<A-Right>", ":wincmd l<CR>")

nmap("<C-l>", ":tabnext<CR>") -- tab shortcuts (control h/L)
nmap("<C-h>", ":tabprevious<CR>")

-- shit from https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/keymaps.lua
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Clear search highlighting with <leader> and c
map("n", "<leader>c", ":nohl<CR>")

-- Toggle auto-indenting for code paste
map("n", "<F2>", ":set invpaste paste?<CR>")
vim.opt.pastetoggle = "<F2>"

-- Reload configuration without restart nvim
map("n", "<leader>r", ":so %<CR>")

-- Fast saving with <leader> and s
map("n", "<leader>w", ":w<CR>")

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Terminal mappings
map("n", "<C-t>", ":Term<CR>", { noremap = true }) -- open
map("t", "<Esc>", "<C-\\><C-n>") -- exit

-- NvimTree
-- map("n", "<C-n>", ":NvimTreeToggle<CR>") -- open/close
-- map("n", "<leader>f", ":NvimTreeRefresh<CR>") -- refresh
-- map("n", "<leader>n", ":NvimTreeFindFile<CR>") -- search file

-- Tagbar
map("n", "<leader>z", ":TagbarToggle<CR>") -- open/close

-- telescope

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- telescope file browser
vim.api.nvim_set_keymap("n", "<leader>fe", ":Telescope file_browser<CR>", { noremap = true })

-- select workspace with telescope
vim.keymap.set("n", "<leader>fw", ":WorkspacesOpen<CR>")

-- Session.nvim
map("n", "<leader>sl", ":SessionsLoad<CR>")
map("n", "<leader>ss", ":SessionsSave<CR>")
map("n", "<leader>st", ":SessionsStop<CR>")
