-- keymaps.lua
local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)
local vscode = require("vscode")

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- default keymaps:
-- Key 	              VSCode Command
-- = / == 	          editor.action.formatSelection
-- gh / K 	          editor.action.showHover
-- gd / C-] 	        editor.action.revealDefinition
--                    Also works in vim help.
-- gf           	    editor.action.revealDeclaration
-- gH 	              editor.action.referenceSearch.trigger
-- gO 	              workbench.action.gotoSymbol
-- C-w gd / C-w gf 	  editor.action.revealDefinitionAside
-- gD 	              editor.action.peekDefinition
-- gF 	              editor.action.peekDeclaration
-- Tab 	              togglePeekWidgetFocus
--                    Switch between peek editor and reference list.
-- C-n / C-p 	        Navigate lists, parameter hints, suggestions, quick-open, cmdline history, peek reference list
